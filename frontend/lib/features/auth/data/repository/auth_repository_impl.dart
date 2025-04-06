import 'package:dartz/dartz.dart';
import 'package:frontend/core/resources/failure.dart';
import 'package:frontend/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:frontend/features/auth/data/models/user.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, UserModel>> login(String email, String password) async {
    return await authRemoteDataSource.login(email: email, password: password);
  }

  @override
  Future<Either<Failure, UserModel>> register( String name, String email, String password,String? photoUrl) async {
    return await authRemoteDataSource.register( name: name, email: email, password: password, photoUrl: photoUrl);
  }

}