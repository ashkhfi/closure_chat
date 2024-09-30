import 'dart:convert';

import 'package:closure/services/chat_service.dart';
import 'package:closure/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/provider.dart';
import '../services/auth_service.dart';
import '../utils/style.dart';
import 'friend.dart';

class FriendTab extends ConsumerWidget {
  FriendTab({super.key});

  List<dynamic> chats = [];

  final u = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showNewChatDialog() async {
      final roomsNotifier = ref.watch(chatRoomNotifierProvider.notifier);
      final userNotifier = ref.watch(userNotifierProvider.notifier);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: SingleChildScrollView(
                  child: Column(
                children: [
                  const Text(
                    'Send  Message to',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: u,
                    decoration: const InputDecoration(
                      prefix: Text('@'),
                      hintText: 'Username',
                      border: InputBorder.none, // Menghilangkan garis bawah
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Material(
                    color: Styles.pink,
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: () async {
                        // final _userService = UserService();
                        // final _authService = AuthService();
                        // final user = await _authService.getCurentUser();
                        // print(user.email);

                        // // Menunggu fetchUserData selesai
                        // await userNotifier.fetchUserData(user.email!);

                        // // Mendapatkan data pengguna
                        // final userData =
                        //     await _userService.getUserData(user.email!);
                        // var a = roomsNotifier.createNewRoom(u.text, userData!);
                        // print("a : $a");
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                            width: double.infinity,
                            child: Center(
                                child: Text(
                              'Chat',
                              style: TextStyle(color: Colors.white),
                            ))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "search username",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              )),
            );
          });
    }

    return Scaffold(
      body: Friends(),
      /*ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, i) {
            final data = chats[i];
            return Padding(
              padding: EdgeInsets.zero, // Mengatur padding menjadi nol untuk semua sisi
              child: Material(
                  elevation: 0, // Mengatur elevation menjadi nol untuk menghilangkan efek bayangan
                  color: Colors.white,
                  child: InkWell(
                      onTap: () {
                        SupabaseHelper().Navigate(
                            context,
                            Chat(
                              roomTitle: data['user2username'],
                              roomId: data['room_id'],
                              otherProfile: data['user2profile'],
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: data['user2profile'],
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(data['user2username'], style: TextStyle(fontSize: 18)), // Menetapkan ukuran font
                          ],
                        ),
                      ))),
            );
          }),*/
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final chatService = ChatService();

          chatService
              .listenToChatRooms('AyzoqNtMXUZyF32cb1NPF1MmQn62')
              .listen((chatRooms) {
            print(
                'Received chat rooms: ${chatRooms.map((c) => c.toMap()).toList()}');
          });
          showNewChatDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
