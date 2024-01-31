import 'package:flash_chat/components/button_widget.dart';
import 'package:flash_chat/components/loading_widget.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  String email = '';
  String password = '';
  String errorMessage = '';

  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  final Logger _logger = Logger();

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
                          text: 'Log In',
                          color: Colors.lightBlueAccent,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                                errorMessage = '';
                              });
                              final AuthResult result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result.user != null) {
                                _logger.i('Successfully signed in');
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
                          style: const TextStyle(
                            color: Colors.red,
                          ),
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
