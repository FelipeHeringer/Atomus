abstract class  AuthState {}

class  AuthStateInitial extends AuthState {}

class AuthStateLoading extends AuthState{}

class AuthStateSuccess extends AuthState{
  final String message;

  AuthStateSuccess({required this.message});
}

class AuthStateFailure extends AuthState{
  final String error;

  AuthStateFailure({required this.error});
}