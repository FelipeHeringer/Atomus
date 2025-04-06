import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:frontend/features/auth/presentation/bloc/auth_event.dart';
import 'package:frontend/features/auth/presentation/bloc/auth_state.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool termsAndConditions = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    BlocProvider.of<AuthBloc>(context).add(
      RegisterEvent(
        name: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  bool _checkIfPasswordIsTheSame(String password, String confirmPassword) {
    if (password == (confirmPassword)) {
      return true;
    }
    return false;
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
              icon: Icons.account_circle_rounded,
              hint: 'Username',
              obscureText: false,
              controller: _usernameController,
            ),
            const SizedBox(height: 16),
            _buildInputField(
              icon: Icons.alternate_email_rounded,
              hint: 'Email',
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 16),
            _buildInputField(
              icon: Icons.lock,
              hint: 'Senha',
              obscureText: obscurePassword,
              controller: _passwordController,
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
            const SizedBox(height: 16),
            _buildInputField(
              icon: Icons.lock,
              hint: 'Confirme a Senha',
              obscureText: obscureConfirmPassword,
              controller: _confirmPasswordController,
              suffix: IconButton(
                icon: Icon(
                  obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Color(0xFF52A7CC),
                ),
                onPressed: () {
                  setState(() {
                    obscureConfirmPassword = !obscureConfirmPassword;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Checkbox(
                    value: termsAndConditions,
                    onChanged: (value) {
                      setState(() {
                        termsAndConditions = value!;
                      });
                    },
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Li e concordo com os ',
                      style: TextStyle(color: Color(0xFF52A7CC)),
                      children: [
                        TextSpan(
                          text: 'Termos e condições',
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
                ],
              ),
            ),
            BlocConsumer<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthStateLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                // Melhor está parte do código adicionar class no widget
                return ElevatedButton(
                  onPressed: () {
                    if (!_checkIfPasswordIsTheSame(
                      _passwordController.text,
                      _confirmPasswordController.text,
                    )) {
                        ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("As senhas não são as mesmas")));
                      return;
                    }
                    _onRegister();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF52A7CC),
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
              },
              listener: (context, state) {
                if (state is AuthStateSuccess) {
                  Navigator.pushNamed(context, '/skills');
                } else if (state is AuthStateFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String hint,
    required bool obscureText,
    required TextEditingController controller,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
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
