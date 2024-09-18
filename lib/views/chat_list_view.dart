// ignore_for_file: non_constant_identifier_names

import 'package:closure/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/style.dart';
import 'friend_tab_view.dart';
import 'near_view.dart';

class ChatListView extends ConsumerWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendRoom = ref.watch(chatRoomNotifierProvider);
    final nearRoom = ref.watch(chatNearRoomNotifierProvider);
    var a = friendRoom.asData!.value;
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/love.png',
                width: 30, // Set the logo size as needed
                height: 30,
              ),
              const Text(
                'Closure',
                style: TextStyle(
                  fontSize: 20, // Set the font size to 20
                  color: Color.fromARGB(
                      255, 66, 66, 66), // Set the text color to grey black
                ),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.white, // Set AppBar background color to white
          elevation: 0, // Remove the shadow or border from the AppBar
          bottom: TabBar(
            labelColor: Colors
                .grey[800], // Set the selected tab text color to grey black
            unselectedLabelColor:
                Colors.grey[800], // Set the unselected tab text color to grey
            indicatorColor:
                Colors.grey[800], // Set the indicator color to grey black
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Friends '),
                    // friendRoom.value?.length != 0
                    //     ? ClipOval(
                    //         child: Container(
                    //             width: 20,
                    //             height: 20,
                    //             color: Styles.pink,
                    //             child: Center(
                    //                 child: Text(
                    //               friendRoom.value!.length.toString(),
                    //               style: const TextStyle(
                    //                   fontSize: 12,
                    //                   color: Colors.white,
                    //                   fontWeight: FontWeight.bold),
                    //             ))))
                    //     : Container()
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Receive Messages '),
                    // nearRoom.value?.length != 0
                    //     ? ClipOval(
                    //         child: Container(
                    //             width: 20,
                    //             height: 20,
                    //             color: Styles.pink,
                    //             child: Center(
                    //                 child: Text(
                    //               nearRoom.value!.length.toString(),
                    //               style: const TextStyle(
                    //                   fontSize: 12,
                    //                   color: Colors.white,
                    //                   fontWeight: FontWeight.bold),
                    //             ))))
                    //     : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 1, // Height of the line
              color: Colors.grey[300], // Color of the line
            ),
            Expanded(
              child: TabBarView(
                children: [
                  const FriendTab(),
                  NearView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
