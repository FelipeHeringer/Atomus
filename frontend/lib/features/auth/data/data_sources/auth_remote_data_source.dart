import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:frontend/core/resources/failure.dart';
import 'package:frontend/features/auth/data/models/user.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final String baseUrl = "http://10.0.2.2:8080/auth";

  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return Right(UserModel.fromJson(jsonDecode(response.body)));
      } else {
        return Left(Failure("Login failed: ${response.body} "));
      }
    } catch (e) {
      return Left(Failure("Error: $e"));
    }
  }

  Future<Either<Failure, UserModel>> register({
    required String name,
    required String email,
    required String password,
    String? photoUrl,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'photoUrl': photoUrl,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return Right(UserModel.fromJson(jsonDecode(response.body)));
      } else {
        return Left(Failure("Registration failed: ${response.body} "));
      }
    } catch (e) {
      return Left(Failure("Error: $e"));
    }
  }
}
