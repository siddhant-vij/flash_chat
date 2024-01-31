import 'package:flash_chat/components/loading_widget.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../components/button_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static const String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = '';
  String password = '';
  String errorMessage = '';
  bool isLoading = false;

  final AuthService _auth = AuthService();
  final Logger _logger = Logger();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Hero(
                          tag: 'logo',
                          child: SizedBox(
                            height: 200.0,
                            child: Image.asset('images/logo.png'),
                          ),
                        ),
                        const SizedBox(
                          height: 48.0,
                        ),
                        TextFormField(
                          decoration: kTextInputDecoration.copyWith(
                            hintText: 'Enter your email',
                          ),
                          validator: (val) => val != null &&
                                  !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(val)
                              ? 'Enter a valid email'
                              : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          decoration: kTextInputDecoration.copyWith(
                            hintText: 'Enter your password',
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Enter a strong password';
                            }
                            String pattern =
                                r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{9,}$';
                            RegExp regex = RegExp(pattern);
                            if (!regex.hasMatch(val)) {
                              return 'Enter a strong password.';
                            }
                            return null;
                          },
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        ButtonWidget(
                          text: 'Register',
                          color: Colors.blueAccent,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                                errorMessage = '';
                              });
                              final AuthResult result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);
                              if (result.user != null) {
                                _logger.i('Successfully signed up');
                                _logger.i(result.user!.uid);
                                // ignore: use_build_context_synchronously
                                Navigator.pushNamed(context, ChatScreen.id);
                              } else {
                                setState(() {
                                  errorMessage = result.errorMessage!;
                                });
                                _logger.i('Failed to sign up');
                                _logger.i(errorMessage);
                              }
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          errorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
