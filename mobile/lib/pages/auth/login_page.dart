import 'package:flutter/material.dart';

import 'package:laudo_ez/constructor/user.dart';
import 'package:laudo_ez/models/auth/auth_service.dart';
import '../../components/auth_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthData authData) async {
    try {
      if(!mounted) return;
      setState(() => _isLoading = true);

      if(authData.isLogin){
        await AuthService().login(
          authData.email!,
          authData.password!
        );
      }
    }catch(error) {
      print(error.toString());
    }finally {
      setState(() => _isLoading = false);
    }
  }

  _loginPageState() {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 400,
            width: 400,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset('assets/icons/Laudo_3.png'),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 250),
            child: Center(
                child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              child: AuthForm(onSubmit: _handleSubmit),
            )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget> [
          if(_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else
            _loginPageState(),
        ],
      ),
    );
  }
}
