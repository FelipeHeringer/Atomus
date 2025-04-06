import 'package:dartz/dartz.dart';
import 'package:frontend/core/resources/failure.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repository.dart';

import '../entities/user.dart';

class RegisterUseCase {

  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  Future<Either<Failure,UserEntity>> call (String name, String email, String password, String? photoUrl) {
    return authRepository.register(name, email, password, photoUrl);
  }
}