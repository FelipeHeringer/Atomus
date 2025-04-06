import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/domain/use_cases/login_use_case.dart';
import 'package:frontend/features/auth/domain/use_cases/register_use_case.dart';
import 'package:frontend/features/auth/presentation/bloc/auth_event.dart';
import 'package:frontend/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;

  AuthBloc({required this.registerUseCase, required this.loginUseCase}) : super (AuthStateInitial()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);

  }

    Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
      emit(AuthStateLoading());
      await Future.delayed(Duration(milliseconds: 500));

      try{
          // ignore: unused_local_variable
          final user =  await  registerUseCase.call(event.name, event.email, event.password,  event.photoUrl);
          emit(AuthStateSuccess(message: "Registrado com Sucesso "));

      } catch(e) {
        emit(AuthStateFailure(error: "Erro ao realizar o Cadastro"));
      }
    }

    Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
      emit(AuthStateLoading());
      await Future.delayed(Duration(milliseconds: 500));

      try{
          // ignore: unused_local_variable
          final user =  await  loginUseCase.call(event.email, event.password);
          emit(AuthStateSuccess(message: "Login realizado com sucesso"));

      } catch(e) {
        emit(AuthStateFailure(error: "Falha no Login"));
      }
    }
}

