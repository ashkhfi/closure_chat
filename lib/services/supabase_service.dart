// // lib/services/supabase_service.dart

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class SupabaseService {
//   final supabase = Supabase.instance.client;
//   static dynamic userData;
//   static SharedPreferences? userPrefs;

//   Future<void> getUserData(String email) async {
//     try {
//       final data = await supabase.from('users').select().eq('email', email);
//       userData = data;
//     } catch (e) {
//       throw (e);
//     }
//   }

//   Future<void> setUserData(BuildContext context, Map<String, dynamic> data) async {
//     final auth = FirebaseAuth.instance;
//     String email = auth.currentUser!.email!;

//     try {
//       final users = await supabase.from('users').select('email').eq('email', email);

//       if (users.isNotEmpty) {
//         await getUserData(email);
//         _navigateToHome(context);
//       } else {
//         await supabase.from('users').insert(data);
//         await getUserData(email);
//         _navigateToProfileSetup(context);
//       }
//     } catch (e) {
//       debugPrint('Error setting user data: $e');
//     }
//   }

//   Future<void> checkUserLogin(BuildContext context) async {
//     if (userPrefs != null && userPrefs!.getBool('login') == true) {
//       _navigateToHome(context);
//     }
//   }

//   Future<void> createNewChat(BuildContext context, String username) async {
//     try {
//       final otherUser = await supabase.from('users').select().eq('username', username);

//       if (otherUser.isEmpty) {
//         _showMessage(context, 'Username not found');
//       } else {
//         final data = otherUser[0];
//         final roomId = '${data['username']}-${userData[0]['uid']}';
//         final chats = await supabase.from('chat_rooms').select().eq('room_id', roomId);

//         if (chats.isEmpty) {
//           await supabase.from('chat_rooms').insert({
//             'room_id': roomId,
//             'room_title': data['username'],
//             'unread1': 0,
//             'unread2': 0,
//             'user1': userData[0]['uid'],
//             'user1profile': userData[0]['image_url'],
//             'user1username': userData[0]['username'],
//             'user2': data['uid'],
//             'user2profile': data['image_url'],
//             'user2username': data['username'],
//           });
//           _navigateToChatPage(context, roomId, data['username'], data['image_url']);
//         } else {
//           _navigateToChatPage(context, roomId, data['username'], data['image_url']);
//         }
//       }
//     } catch (e) {
//       debugPrint("ERROR: $e");
//     }
//   }

//   Future<List<dynamic>> getChats() async {
//     final chats = await supabase.from('chat_rooms').select().like('room_id', '%${userData[0]['uid']}%');
//     return chats;
//   }

//   Future<List<dynamic>> getFilteredChats(String uid, String username) async {
//     final chats = await supabase.from('chat_rooms').select().eq('user2', uid);
//     return chats;
//   }

//   void _showMessage(BuildContext context, String text) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
//   }

//   void _navigateToHome(BuildContext context) {
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => const MainPage()),
//       (route) => false,
//     );
//   }

//   void _navigateToProfileSetup(BuildContext context) {
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => const ProfileSetupPage()),
//       (route) => false,
//     );
//   }

//   void _navigateToChatPage(BuildContext context, String roomId, String title, String imageUrl) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ChatPage(type: 'friends', room_id: roomId, title: title, image_url: imageUrl),
//       ),
//     );
//   }
// }
