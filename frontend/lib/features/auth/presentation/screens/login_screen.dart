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
                color: Color(0xFFFFFFFF),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Image.asset('assets/atomus_logo.png', height: 159.08, width: 191),
            const SizedBox(height: 21),
            Text(
              "Login",
              style: GoogleFonts.montserrat(
                color: Color(0xFFFFFFFF),
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            _buildInputField(
              icon: Icons.account_circle_sharp,
              hint: 'Email',
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
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
              ),
            ),
            const SizedBox(height: 13),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Esqueci a senha',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
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
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Entrar',
                    style: GoogleFonts.montserrat(
                      color: Color(0xFFFFFFFF),
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
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
            ElevatedButton.icon(
              onPressed: () {},
              icon: Image.asset('assets/google.png', height: 34, width: 34),
              label: Text(
                'Entrar com conta Google',
                style: GoogleFonts.montserrat(
                  color: Color(0xFF000000),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shadowColor: Colors.black26,
                elevation: 4,
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: 'Não tem uma conta ? ',
                style: GoogleFonts.montserrat(
                  color: Color(0xFFFFFFFF),
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: 'Cadastre-se',
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF3FBFB2),
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
      style: GoogleFonts.montserrat(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
          size: 24,
        ),
        suffixIcon: suffix,
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFFFFFFF)),
        enabledBorder: OutlineInputBorder(
          borderSide:  BorderSide(color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
