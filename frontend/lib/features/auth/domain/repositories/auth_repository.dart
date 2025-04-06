import 'package:dartz/dartz.dart';
import 'package:frontend/core/resources/failure.dart';
import 'package:frontend/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure,UserEntity>> login(String email, String password);
  Future<Either<Failure,UserEntity>> register(String name, String email, String password, String? photoUrl);
}