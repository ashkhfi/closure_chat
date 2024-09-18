class UserModel {
  final int id;
  final String username;
  final String imageUrl;
  final String uid;
  final String email;
  final String fcmToken;  // Tambahkan field fcmToken

  UserModel({
    required this.id,
    required this.username,
    required this.imageUrl,
    required this.uid,
    required this.email,
    required this.fcmToken,  // Inisialisasi field fcmToken
  });

  // Factory untuk mengubah Map ke UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? 0,
      username: map['username'] ?? '',
      imageUrl: map['image_url'] ?? '',
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      fcmToken: map['fcm_token'] ?? '',  // Ambil fcmToken dari Map
    );
  }

  // Method untuk mengubah UserModel ke Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'image_url': imageUrl,
      'uid': uid,
      'email': email,
      'fcm_token': fcmToken,  // Tambahkan fcmToken ke Map
    };
  }
}
