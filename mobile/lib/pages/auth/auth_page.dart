import 'package:flutter/material.dart';

import '../../components/auth_form.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 400,
            width: 400,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset('assets/icons/Laudo.png'),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 250),
            child: const Center(
                child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              child: AuthForm(),
            )),
          ),
        ],
      ),
    );
  }
}
