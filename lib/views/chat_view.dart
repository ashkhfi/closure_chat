// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:closure/providers/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/chat_notifier.dart';
import '../utils/style.dart';

class ChatPage extends ConsumerWidget {
  final String room_id;
  final String title;
  final String image_url;
  final String type;

  const ChatPage(
      {super.key,
      required this.type,
      required this.room_id,
      required this.title,
      required this.image_url});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatTextController = TextEditingController();
    final scrollController = ScrollController(); // Tambahkan ScrollController
    final chats = ref.watch(chatsProvider(room_id));
    final userData = ref.watch(userNotifierProvider).value;

    // Fungsi untuk menggulir ke bawah
    void scrollToBottom() {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }

    // Tambahkan ini untuk menggulir ke bawah setelah data dimuat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
            )),
        title: Row(
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: image_url,
                width: 36,
                height: 36,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(title)
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: chats.isEmpty
                ? const Center(child: Text('No chats'))
                : ListView.builder(
                    controller: scrollController, // Tambahkan controller
                    itemCount: chats.length,
                    itemBuilder: (context, i) {
                      final chat = chats[i];
                      return Padding(
                        padding:
                            const EdgeInsets.only(bottom: 8, right: 8, left: 8),
                        child: Align(
                          alignment: chat.sender_id == userData!.uid
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Material(
                            color: chat.sender_id == userData.uid
                                ? Styles.pink
                                : const Color.fromARGB(255, 165, 165, 165),
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                chat.message,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.white,
                    elevation: 1,
                    child: TextField(
                      controller: chatTextController,
                      maxLines: 4, // Mengubah maxLines
                      minLines: 1, // Mengubah minLines
                      decoration: InputDecoration(
                        fillColor: const Color.fromARGB(
                            255, 225, 225, 225), // Mengubah warna latar
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(
                              30.0), // Mengubah borderRadius
                        ),
                        hintText: 'Enter message',
                        hintStyle:
                            const TextStyle(fontSize: 14), // Mengubah gaya hint
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (chatTextController.text.isNotEmpty) {
                        // sendChat(chatTextController.text, room_id, type);
                        ref.read(chatsProvider(room_id).notifier).sendMessage(
                            chatTextController.text, userData!.uid, type);
                        chatTextController.clear();
                        scrollToBottom(); // Panggil fungsi scrollToBottom setelah mengirim pesan
                      }
                    },
                    icon: Icon(
                      Icons.send,
                      color: Styles.pink,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
