import 'package:frontend/features/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String name,
    required String email,
    required String password,
    String? photoUrl,
  }) : super(
    id: id,
    name: name,
    email: email,
    password: password,
  );

  factory UserModel.fromJson(Map<String,dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'], 
      password: json['password'],
      photoUrl: json['photoUrl'] ?? "",
    );
  }
}