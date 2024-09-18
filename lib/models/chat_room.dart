// ignore_for_file: non_constant_identifier_names

class ChatRoomsModel {
  final int id;
  final String room_id;
  final String room_title;
  final int unread1;
  final int unread2;
  final String user1;
  final String user1username;
  final String user1profile;
  final String user2;
  final String user2username;
  final String user2profile;
  final int unreads;

  ChatRoomsModel(
      {required this.id,
      required this.room_id,
      required this.room_title,
      required this.unread1,
      required this.unread2,
      required this.user1,
      required this.user1profile,
      required this.user1username,
      required this.user2,
      required this.user2profile,
      required this.user2username,
      this.unreads = 0});

  factory ChatRoomsModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomsModel(
      id: map['id'],
      room_id: map['room_id'],
      room_title: map['room_title'],
      unread1: map['unread1'],
      unread2: map['unread2'],
      user1: map['user1'],
      user1username: map['user1username'],
      user1profile: map['user1profile'],
      user2: map['user2'],
      user2username: map['user2username'],
      user2profile: map['user2profile'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'room_id': room_id,
      'room_title': room_title,
      'unread1': unread1,
      'unread2': unread2,
      'user1': user1,
      'user1username': user1username,
      'user1profile': user1profile,
      'user2': user2,
      'user2username': user2username,
      'user2profile': user2profile,
      'unreads': unreads,
    };
  }
}
