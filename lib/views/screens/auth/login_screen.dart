import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mf_ip/bloc/auth_bloc.dart';
import 'package:mf_ip/views/widgets/custom_button.dart';

import '../../widgets/custom_snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            context.go("/schemes");
          }
          // CustomSnackBar.show(context, message: state.toString());
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.black26,
                ),
                child: Column(
                  children: [
                    Text(
                      "Welcome back!",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Email"),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Password"),
                        suffixIcon: Icon(Icons.visibility_off),
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (state.status == AuthStatus.loading)
                      Center(child: CircularProgressIndicator())
                    else
                      CustomAppButton(
                        title: "Login",
                        color: Colors.black,
                        onTap: () {
                          var email = _emailController.text
                              .trim()
                              .toLowerCase();
                          var password = _passwordController.text;
                          if (_emailController.text.trim().isEmpty) {
                            CustomSnackBar.show(
                              context,
                              message: "Please enter a valid email!",
                            );
                            return;
                          }
                          if (_passwordController.text.length < 9) {
                            CustomSnackBar.show(
                              context,
                              message: "Password length must be greater than 9",
                            );
                            return;
                          }

                          context.read<AuthBloc>().add(
                            LoginWithEmailPassword(
                              email: email,
                              password: password,
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
