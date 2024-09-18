import 'dart:async';
import 'dart:convert';

import 'package:closure/services/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import '../services/chat_service.dart';
import '../models/chat_room.dart';

// ChatRoomsNotifier class untuk mengelola state chat rooms
class NearRoomsNotifier extends AsyncNotifier<List<ChatRoomsModel>> {
  final chatService = ChatService();
  final authService = AuthService();
  final userService = UserService();

  Future<List<ChatRoomsModel>> fetchChatRooms(String uid) async {
    var chatList = chatService.listenToChatRooms(uid).first;
    // print('User Data: ${jsonEncode(chatList)}');
    return chatList;
  }

  void _listenToChatRooms(String uid) {
    chatService.listenToChatRooms(uid).listen((chatRooms) {
      state = AsyncData(chatRooms); // Update state dengan data terbaru
    });
  }

  void _listenToChatRoomsNear(String uid) {
    chatService.listenToNearRooms(uid).listen((chatRooms) {
      state = AsyncData(chatRooms); // Update state dengan data terbaru
    });
  }
  @override
  FutureOr<List<ChatRoomsModel>> build() async {
    state = const AsyncLoading();
    final user = await authService.getCurentUser();
    print(user.email);
    final userData = await userService.getUserData(user.email!);
    final chatRooms = await fetchChatRooms(userData!.uid);
    _listenToChatRoomsNear(userData.uid);

    return chatRooms;
  }
}
