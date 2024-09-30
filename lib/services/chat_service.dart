import 'dart:convert';
import 'package:closure/models/user_model.dart';
import 'package:flutter/material.dart';
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

  Future<void> cacheChatRooms(List<ChatRoomsModel> rooms) async {
    final box = Hive.box('chatCache');
    final roomsMap = rooms.map((room) => room.toMap()).toList();
    await box.put('chatRooms', roomsMap);
  }

  Future<List<ChatRoomsModel>> getCachedChatRooms() async {
    final box = Hive.box('chatCache');
    final cachedRooms = box.get('chatRooms') ?? [];
    return cachedRooms
        .map<ChatRoomsModel>((data) => ChatRoomsModel.fromMap(data))
        .toList();
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
        .stream(primaryKey: ['id']).eq('user1', userId)) {
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
        .stream(primaryKey: ['id']).eq('user2', userId)) {
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
    return cachedChats
        .map<ChatsModel>((data) => ChatsModel.fromMap(data))
        .toList();
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
    final lastAccess =
        box.get('lastAccess') ?? DateTime.now().subtract(Duration(days: 7));

    if (DateTime.now().difference(lastAccess).inDays > 7) {
      await box.clear();
    }

    await box.put('lastAccess', DateTime.now());
  }

  Future<bool> createNewChat(String u, UserModel user) async {
    debugPrint('Menciptakan chat baru dengan pengguna: $u');
    try {
      final otherUser =
          await _supabase.from('users').select().eq('username', u);
      debugPrint('Pengguna lain ditemukan: ${otherUser.toString()}');
      if (otherUser.isEmpty) {
        return false;
      } else {
        final data = otherUser[0];
        final roomId = '${data['username']}-$user.uid}';
        final chats =
            await _supabase.from('chat_rooms').select().eq('room_id', roomId);
        debugPrint('Chat ditemukan: ${chats.toString()}');
        if (chats.isEmpty) {
          await _supabase.from('chat_rooms').insert({
            'room_id': roomId,
            'room_title': data['username'],
            'unread1': 0,
            'unread2': 0,
            'user1': user.uid,
            'user1profile': user.imageUrl,
            'user1username': user.username,
            'user2': data['uid'],
            'user2profile': data['image_url'],
            'user2username': data['username'],
          });

          return true;
        }
      }
    } catch (e) {
      debugPrint("ERROR: $e");
    }
    return false;
  }
}
