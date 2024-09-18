// ignore_for_file: non_constant_identifier_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../providers/provider.dart';
import '../utils/style.dart';
import 'chat_view.dart';

class NearView extends ConsumerWidget {
  final supabase = Supabase.instance.client;
  NearView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatRoomState = ref.watch(chatNearRoomNotifierProvider);
    return Scaffold(
        body: chatRoomState.when(
      data: (nearRooms) {
        return nearRooms.isEmpty
            ? const Center(child: Text('No message'))
            : ListView.builder(
                itemCount: nearRooms.length,
                itemBuilder: (context, i) {
                  final chat = nearRooms[i];
                  return InkWell(
                    onTap: () {
                      // update(chat.room_id);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatPage(
                                    type: 'near',
                                    room_id: chat.room_id,
                                    title: chat.user1username,
                                    image_url: chat.user1profile,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipOval(
                              child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: chat.user1profile,
                              width: 36,
                              height: 36,
                              fit: BoxFit.cover,
                            ),
                          )),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(child: Text(chat.user1username)),
                          chat.unread2 != 0
                              ? ClipOval(
                                  child: Container(
                                      width: 25,
                                      height: 25,
                                      color: Styles.pink,
                                      child: Center(
                                          child: Text(
                                        chat.unread2.toString(),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ))))
                              : Container()
                        ],
                      ),
                    ),
                  );
                });
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    ));
  }
}
