import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_mobile/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:shop_mobile/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:shop_mobile/features/auth/presentation/pages/register_screen.dart';
import 'package:shop_mobile/features/auth/presentation/widgets/auth_action_button.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';

  void _login() async {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      BlocProvider.of<AuthBloc>(context).add(
        AuthLogin(
          email: _enteredEmail,
          password: _enteredPassword,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _form,
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                child: Column(
                  children: [
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(),
                    ),
                    const SizedBox(height: 6),
                    const Text('Fill the form to login'),
                    TextFormField(
                      key: const Key('email_field'),
                      decoration: const InputDecoration(
                        label: Text('Email'),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            value.trim().length < 5 ||
                            !value.trim().contains('@')) {
                          return "Email must be a valid email.";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _enteredEmail = newValue!;
                      },
                    ),
                    TextFormField(
                      key: const Key('password_field'),
                      decoration: const InputDecoration(
                        label: Text('Password'),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.trim().length < 6) {
                          return "Please enter a valid password.";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _enteredPassword = newValue!;
                      },
                    ),
                    const SizedBox(height: 18),
                    AuthActionButton(onSubmit: _login, type: 'Login'),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RegisterScreen.routeName);
                        },
                        child: Text(
                          'Register',
                          textAlign: TextAlign.left,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
