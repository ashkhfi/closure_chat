// ignore_for_file: non_constant_identifier_names

class ChatsModel {
  final int id;
  final String message;
  final String room_id;
  final String sender_id;
  final bool unread;

  ChatsModel({
    required this.id,
    required this.message,
    required this.room_id,
    required this.sender_id,
    required this.unread,
  });

  // Konversi dari Map ke ChatsModel
  factory ChatsModel.fromMap(Map<String, dynamic> map) {
    return ChatsModel(
      id: map['id'],
      message: map['message'],
      room_id: map['room_id'],
      sender_id: map['sender_id'],
      unread: map['unread'],
    );
  }

  // Konversi dari ChatsModel ke Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'room_id': room_id,
      'sender_id': sender_id,
      'unread': unread,
    };
  }
}
