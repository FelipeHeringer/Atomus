abstract class AuthEvent{}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  String? photoUrl;

  RegisterEvent({required this.name,required this.email, required this.password,this.photoUrl});
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}