import 'dart:async';
import 'package:closure/models/user_model.dart';
import 'package:closure/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends AsyncNotifier<void> {
  final _googleSignInService = AuthService();

  Future<void> signInWithGoogle() async {
    try {
      await _googleSignInService.signInWithGoogle();
      state = const AsyncValue.data(null);
    } catch (e) {
      print('Error signing in with Google: $e');
      state =
          AsyncValue.error('Failed to sign in with Google', StackTrace.current);
    }
  }

  Future<String> getCurentUser() async {
    final curentUser = await _googleSignInService.getCurentUser();
    print(curentUser.id);
    return curentUser.id;
  }

  Future<void> signOut() async {
    await _googleSignInService.signOut();
    state = const AsyncValue.data(null);
  }

  @override
  FutureOr<void> build() async {
    state = const AsyncLoading();
    await signInWithGoogle();
  }
}
