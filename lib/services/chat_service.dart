import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/chat_model.dart';
import '../models/chat_room.dart';

class ChatService {
  final _supabase = Supabase.instance.client;

  Future<void> sendChat(
      String message, String roomId, String type, String senderId) async {
    await _supabase.from('chats').insert({
      'message': message,
      'room_id': roomId,
      'sender_id': senderId,
    });

    // Kirim push notifikasi menggunakan FCM
    await _sendPushNotification(message, roomId, senderId);

    if (type == 'near') {
      final count = await _supabase
          .from('chat_rooms')
          .select('unread1')
          .eq('room_id', roomId)
          .single();
      final newCount = count['unread1'] + 1;
      await _supabase
          .from('chat_rooms')
          .update({'unread1': newCount}).eq('room_id', roomId);
    } else if (type == 'friends') {
      final count = await _supabase
          .from('chat_rooms')
          .select('unread2')
          .eq('room_id', roomId)
          .single();
      final newCount = count['unread2'] + 1;
      await _supabase
          .from('chat_rooms')
          .update({'unread2': newCount}).eq('room_id', roomId);
    }
  }

  Future<void> _sendPushNotification(String message, String roomId, String senderId) async {
    final firebaseServerKey = 'YOUR_FIREBASE_SERVER_KEY';

    // Ambil token penerima (misal dari Supabase)
    final chatRoom = await _supabase
        .from('chat_rooms')
        .select('user1, user2')
        .eq('room_id', roomId)
        .single();

    final receiverId = chatRoom['user1'] == senderId ? chatRoom['user2'] : chatRoom['user1'];

    final receiverData = await _supabase
        .from('users')
        .select('fcm_token')
        .eq('uid', receiverId)
        .single();

    final fcmToken = receiverData['fcm_token'];

    // Jika token FCM tersedia, kirim push notifikasi
    if (fcmToken != null && fcmToken.isNotEmpty) {
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$firebaseServerKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'to': fcmToken,
            'notification': <String, dynamic>{
              'title': 'New Message',
              'body': message,
            },
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'roomId': roomId,
            },
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Notifikasi berhasil dikirim');
      } else {
        print('Gagal mengirim notifikasi: ${response.body}');
      }
    }
  }

  Future<void> cacheChatRooms(List<ChatRoomsModel> rooms) async {
    final box = Hive.box('chatCache');
    final roomsMap = rooms.map((room) => room.toMap()).toList();
    await box.put('chatRooms', roomsMap);
  }

  Future<List<ChatRoomsModel>> getCachedChatRooms() async {
    final box = Hive.box('chatCache');
    final cachedRooms = box.get('chatRooms') ?? [];
    return cachedRooms.map<ChatRoomsModel>((data) => ChatRoomsModel.fromMap(data)).toList();
  }

  Stream<List<ChatRoomsModel>> listenToChatRooms(String userId) async* {
    // Emit cached data terlebih dahulu
    final cachedRooms = await getCachedChatRooms();
    if (cachedRooms.isNotEmpty) {
      yield cachedRooms;
    }

    // Listen to updates dari server
    await for (final event in _supabase
        .from('chat_rooms')
        .stream(primaryKey: ['id'])
        .eq('user1', userId)) {
      final rooms = event.map((data) => ChatRoomsModel.fromMap(data)).toList();
      // Cache data terbaru
      await cacheChatRooms(rooms);
      // Emit data yang terbaru dari server
      yield rooms;
    }
  }

  // Stream untuk Near Rooms dengan cache
  Stream<List<ChatRoomsModel>> listenToNearRooms(String userId) async* {
    // Emit cached data terlebih dahulu
    final cachedRooms = await getCachedChatRooms();
    if (cachedRooms.isNotEmpty) {
      yield cachedRooms;
    }

    // Listen to updates dari server
    await for (final event in _supabase
        .from('chat_rooms')
        .stream(primaryKey: ['id'])
        .eq('user2', userId)) {
      final rooms = event.map((data) => ChatRoomsModel.fromMap(data)).toList();
      // Cache data terbaru
      await cacheChatRooms(rooms);
      // Emit data yang terbaru dari server
      yield rooms;
    }
  }

  // Cache Chats ke Hive
  Future<void> cacheChats(String roomId, List<ChatsModel> chats) async {
    final box = Hive.box('chatCache');
    final chatsMap = chats.map((chat) => chat.toMap()).toList();
    await box.put('chats_$roomId', chatsMap);
  }

  // Mendapatkan cached Chats
  Future<List<ChatsModel>> getCachedChats(String roomId) async {
    final box = Hive.box('chatCache');
    final cachedChats = box.get('chats_$roomId') ?? [];
    return cachedChats.map<ChatsModel>((data) => ChatsModel.fromMap(data)).toList();
  }

  // Stream Chats dengan cache
  Stream<List<ChatsModel>> listenToChats(String roomId) async* {
    // Emit cached data terlebih dahulu
    final cachedChats = await getCachedChats(roomId);
    if (cachedChats.isNotEmpty) {
      yield cachedChats;
    }

    // Listen to updates dari server
    await for (final event in _supabase
        .from('chats')
        .stream(primaryKey: ['id'])
        .eq('room_id', roomId)
        .order('date', ascending: true)) {
      final chats = event.map((e) => ChatsModel.fromMap(e)).toList();
      // Cache data terbaru
      await cacheChats(roomId, chats);
      // Emit data yang terbaru dari server
      yield chats;
    }
  }

  // Clear cache (jika dibutuhkan)
  Future<void> clearOldCache() async {
    final box = Hive.box('chatCache');
    final lastAccess = box.get('lastAccess') ?? DateTime.now().subtract(Duration(days: 7));

    if (DateTime.now().difference(lastAccess).inDays > 7) {
      await box.clear();
    }

    await box.put('lastAccess', DateTime.now());
  }
}
