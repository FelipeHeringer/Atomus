import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:frontend/features/auth/data/repository/auth_repository_impl.dart';
import 'package:frontend/features/auth/domain/use_cases/login_use_case.dart';
import 'package:frontend/features/auth/domain/use_cases/register_use_case.dart';
import 'package:frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:frontend/features/auth/presentation/screens/login_screen.dart';
import 'package:frontend/features/auth/presentation/screens/register_screen.dart';
import 'package:frontend/features/skills/presentation/screens/interest_plan_screen.dart';
import 'package:frontend/features/skills/presentation/screens/interest_profile_screen.dart';
import 'package:frontend/welcome_screen.dart';

void main() {
  final authRepository = AuthRepositoryImpl(
    authRemoteDataSource: AuthRemoteDataSource(),
  );
  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  const MyApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => AuthBloc(
                registerUseCase: RegisterUseCase(
                  authRepository: authRepository,
                ),
                loginUseCase: LoginUseCase(authRepository: authRepository),
              ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Atomus",
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Color(0xFF011F27),
            secondary: Color(0xFF3FBFB2),
            tertiary: Color(0xFFD94F04),
          ),
        ),
        home: const LoginScreen(),
        routes: {
          '/login': (_) => LoginScreen(),
          '/register': (_) => RegisterScreen(),
          '/welcome': (_) => WelcomeScreen(),
          '/skills': (_) => SkillsProfileScreen(),
          '/interest_plan': (_) => InterestPlanScreen(),
        },
      ),
    );
  }
}
