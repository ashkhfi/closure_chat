import 'dart:convert';

import 'package:closure/services/chat_service.dart';
import 'package:closure/services/user_service.dart';
import 'package:flutter/material.dart';

import '../utils/style.dart';
import 'friend.dart';

class FriendTab extends StatefulWidget {
  const FriendTab({super.key});

  @override
  State<FriendTab> createState() => _FriendTabState();
}

class _FriendTabState extends State<FriendTab> {
  List<dynamic> chats = [];

  @override
  void initState() {
    super.initState();
  }

  final u = TextEditingController();
  void showNewChatDialog() async {
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
                      // await SupabaseHelper().createNewChat(context, u.text);
                      // Memanggil fungsi load untuk memperbarui daftar chat
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

  @override
  Widget build(BuildContext context) {
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
          // showNewChatDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
