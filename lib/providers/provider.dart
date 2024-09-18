import 'package:closure/models/chat_room.dart';
import 'package:closure/notifiers/auth_notifier.dart';
import 'package:closure/notifiers/chat_room_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_model.dart';
import '../models/user_model.dart';
import '../notifiers/chat_notifier.dart';
import '../notifiers/near_room_notifier.dart';
import '../notifiers/user_notifier.dart';

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, void>(() {
  return AuthNotifier();
});

final currentUserProvider = FutureProvider<String>((ref) async {
  final service = ref.watch(authNotifierProvider.notifier);
  return await service.getCurentUser();
});
final userNotifierProvider = AsyncNotifierProvider<UserNotifier, UserModel>(() {
  return UserNotifier();
});

final chatRoomNotifierProvider = AsyncNotifierProvider<ChatRoomsNotifier, List<ChatRoomsModel>>(() {
  return ChatRoomsNotifier();
});
final chatNearRoomNotifierProvider = AsyncNotifierProvider<NearRoomsNotifier, List<ChatRoomsModel>>(() {
  return NearRoomsNotifier();
});

 final chatsProvider =
      StateNotifierProvider.family<ChatsNotifier, List<ChatsModel>, String>(
    (ref, roomId) {
      return ChatsNotifier(roomId: roomId);
    },
  );




