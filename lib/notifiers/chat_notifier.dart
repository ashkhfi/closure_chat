import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/chat_model.dart';
import '../services/chat_service.dart';

class ChatsNotifier extends StateNotifier<List<ChatsModel>> {
  final String roomId;

  ChatsNotifier({required this.roomId}) : super([]) {
    _listenToChats();
  }
  final _chatsService = ChatService();
  void _listenToChats() {
    final stream = _chatsService.listenToChats(roomId);

    stream.listen((event) {
      state = event; 
    }).onError((error) {
      debugPrint('Error listening to chats: $error');
    });
  }

  Future<void> sendMessage(String message, String senderId, String type) async {
    try {
      await _chatsService.sendChat(message, roomId, type, senderId);
    } catch (error) {
      debugPrint('Error sending chat: $error');
    }
  }

}
