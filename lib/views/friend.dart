import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/provider.dart';
import '../utils/style.dart';
import 'chat_view.dart';

class Friends extends ConsumerWidget {
  Friends({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatRoomState = ref.watch(chatRoomNotifierProvider);

    return Scaffold(
      body: chatRoomState.when(
        data: (chatRooms) {
          return chatRooms.isEmpty
              ? Center(child: Text('No chat rooms available.'))
              : ListView.builder(
                  itemCount: chatRooms.length,
                  itemBuilder: (context, i) {
                    final chat = chatRooms[i];
                    return InkWell(
                      onTap: () {
                        // update(chat.room_id);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatPage(
                                      type: 'friends',
                                      room_id: chat.room_id,
                                      title: chat.user2username,
                                      image_url: chat.user2profile,
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            // Uncomment and update the image loading logic
                            ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: chat.user2profile,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                chat.user2username,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            chat.unread1 != 0
                                ? ClipOval(
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      color: Styles.pink,
                                      child: Center(
                                        child: Text(
                                          chat.unread1.toString(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
