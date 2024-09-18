import 'dart:convert';

import 'package:closure/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  final _supabase = Supabase.instance.client;

  Future<UserModel?> getUserData(String email) async {
  final data = await _supabase
      .from('users')
      .select()
      .eq('email', email) // Gunakan parameter email
      .maybeSingle();

  if (data == null || data.isEmpty) {
    print("No data found");
    return null;
  } else {
    final userModel = UserModel.fromMap(data);
    print('User Data: ${jsonEncode(userModel.toMap())}'); // Mencetak data dalam format JSON
    return userModel;
  }
}

  Future<void> createUser(UserModel userModel) async {
    final user = await _supabase.from('users').insert({
      'id': userModel.id,
      'username': userModel.username,
      'imageUrl': userModel.imageUrl,
      'email': userModel.email,
    });
    return user;
  }
}
