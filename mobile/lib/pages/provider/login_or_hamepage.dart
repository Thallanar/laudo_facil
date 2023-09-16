import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../constructor/user.dart';
import '../../models/auth/auth_service.dart';
import '../auth/login_page.dart';
import '../homepage.dart';

class LoginOrHomepage extends StatelessWidget {
  const LoginOrHomepage({Key? key}) : super(key: key);

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
  }

  _loadingPage(){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator.adaptive(
              valueColor: const AlwaysStoppedAnimation(Colors.black),
              backgroundColor: Colors.grey[200],
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Text(
                'Carregando...',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                )
              ),
            )
          ],
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (ctx, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return _loadingPage();
        } else {
          return StreamBuilder<AppUser?>(
            stream: AuthService().dataChanges,
            builder: (ctx, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return _loadingPage();
              }else{
                return snapshot.hasData ? const HomePage() : const LoginPage();
              }
            },
          );
        }
      },
    );
  }
}
