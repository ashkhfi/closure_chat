// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'package:closure/models/message.dart';

// class MessageSearchDelegate extends SearchDelegate<Message?> {
//   final String chatRoomId;
//   final void Function(Message) onMessageTap;

//   MessageSearchDelegate({
//     required this.chatRoomId,
//     required this.onMessageTap,
//   });

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//         .collection('chat_rooms')
//         .doc(chatRoomId)
//         .collection('messages')
//         .orderBy('timestamp', descending: true)
//         .snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final results = snapshot.data!.docs
//           .map((doc) => Message.fromMap(doc.data() as Map<String, dynamic>))
//           .where((msg) => msg.text.toLowerCase().contains(query.toLowerCase()))
//           .toList();

//         return ListView.builder(
//           itemCount: results.length,
//           itemBuilder: (context, index) {
//             final message = results[index];
//             return ListTile(
//               title: Text(message.text),
//               // ignore: unnecessary_null_comparison
//               subtitle: Text(message.timestamp != null
//                 ? DateFormat('hh:mm a').format(message.timestamp.toDate())
//                 : ''),
//               onTap: () {
//                 onMessageTap(message);
//                 close(context, message);
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return Container();
//   }
// }
