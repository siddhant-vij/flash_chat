import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

import '../components/button_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static const String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
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
                TextField(
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  decoration: kInputTextStyleDecoration.copyWith(
                    hintText: 'Enter your email',
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  decoration: kInputTextStyleDecoration.copyWith(
                    hintText: 'Enter your password',
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                ButtonWidget(
                  text: 'Register',
                  color: Colors.blueAccent,
                  onPressed: () {
                    //Implement registration functionality.
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
