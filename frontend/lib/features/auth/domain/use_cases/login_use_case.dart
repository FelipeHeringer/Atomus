import 'package:dartz/dartz.dart';
import 'package:frontend/core/resources/failure.dart';
import 'package:frontend/features/auth/domain/entities/user.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase  {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<Either<Failure,UserEntity>> call (String email, String password) {
    return authRepository.login(email,password);
  }
  
}