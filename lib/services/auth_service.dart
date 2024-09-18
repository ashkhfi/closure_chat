import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _googleSignIn = GoogleSignIn(
    clientId:
        '525596284092-m8aq3a7h86dp6rtpg9imaud3o08fp17p.apps.googleusercontent.com',
  );

  final supabase = Supabase.instance.client;

  
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }

  // Get current user function
  Future<User> getCurentUser() async => supabase.auth.currentUser!;

  // Update FCM token function
  Future<void> updateFcmToken(String userId) async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await supabase
          .from('users')
          .update({'fcm_token': token}).eq('uid', userId);
    }
  }

  // Sign in with Google function
  Future<void> signInWithGoogle() async {
    const webClientId =
        '525596284092-m8aq3a7h86dp6rtpg9imaud3o08fp17p.apps.googleusercontent.com';

    const iosClientId = 'my-ios.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    // Sign in to Supabase using Google ID token
    await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    // Get current user from Supabase
    final currentUser = supabase.auth.currentUser;

    // After successful login, update the FCM token
    if (currentUser != null) {
      await updateFcmToken(currentUser.id);
    }
  }
}
