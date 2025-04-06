import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:frontend/features/auth/presentation/bloc/auth_event.dart';
import 'package:frontend/features/auth/presentation/bloc/auth_state.dart';
import 'package:frontend/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    BlocProvider.of<AuthBloc>(context).add(
      LoginEvent(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ATOMUS",
              style: GoogleFonts.montserrat(
                color: Color(0xFF52A7CC),
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Icon(
              Icons.all_inclusive_sharp,
              color: Color(0xFF52A7CC),
              size: 72,
            ),
            const SizedBox(height: 32),
            _buildInputField(
              icon: Icons.account_circle_sharp,
              hint: 'Username ou Email',
              controller: _emailController,
              obscureText: false,
            ),
            const SizedBox(height: 16),
            _buildInputField(
              icon: Icons.lock,
              hint: 'Senha',
              controller: _passwordController,
              obscureText: obscurePassword,
              suffix: IconButton(
                icon: Icon(
                  obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Color(0xFF52A7CC),
                ),
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Esqueci a senha',
                  style: TextStyle(
                    color: Color(0xFF52A7CC),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            BlocConsumer<AuthBloc, AuthState>(
              builder: (context, state) {
                 if (state is AuthStateLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                  onPressed: _onLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF52A7CC),
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
              },
              listener: (context, state) {
                if (state is AuthStateSuccess) {
                    ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                  Navigator.pushNamed(context, '/register');
                } else if (state is AuthStateFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
            ),

            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: 'Não tem uma conta? ',
                style: TextStyle(color: Color(0xFF52A7CC)),
                children: [
                  TextSpan(
                    text: 'Crie uma',
                    style: TextStyle(
                      color: Color(0xFF52A7CC),
                      decoration: TextDecoration.underline,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Image.asset('assets/google.png', height: 24),
              label: const Text(
                'Entrar com conta Google',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shadowColor: Colors.black26,
                elevation: 4,
                minimumSize: const Size.fromHeight(48),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String hint,
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Color(0xFF52A7CC)),
        suffixIcon: suffix,
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF52A7CC)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF52A7CC)),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF52A7CC)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
