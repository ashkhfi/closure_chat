

class Message {
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isSent;
  final bool isRead;

  Message({
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isSent,
    required this.isRead,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] ?? '',
      text: map['text'] ?? '',
      timestamp: map['timestamp'] ?? '',
      isSent: map['isSent'] ?? false,
      isRead: map['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'timestamp': timestamp,
      'isSent': isSent,
      'isRead': isRead,
    };
  }
}
