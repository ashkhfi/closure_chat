import 'dart:async';

import 'package:closure/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserNotifier extends AsyncNotifier<UserModel> {
  final _userService = UserService();
  final _authService = AuthService();

  Future<void> fetchUserData(String userId) async {
    try {
      final userData = await _userService.getUserData(userId);
      if (userData != null) {
        state = AsyncValue.data(userData);
      } else {
        state = AsyncValue.error('User data not found', StackTrace.current);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  @override
  FutureOr<UserModel> build() async {
    state = const AsyncLoading();
    final user = await _authService.getCurentUser();
    print(user.email);

    // Menunggu fetchUserData selesai
    await fetchUserData(user.email!);

    // Mendapatkan data pengguna
    final userData = await _userService.getUserData(user.email!);

    // Memeriksa jika data pengguna ada
    if (userData != null) {
      return userData; // Kembalikan data pengguna jika tidak null
    } else {
      throw Exception('User data not found');
    }
  }
}
