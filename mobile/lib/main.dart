import 'package:flutter/material.dart';
import 'package:laudo_ez/models/auth/auth_service.dart';
import 'package:laudo_ez/pages/provider/login_or_hamepage.dart';
import 'package:laudo_ez/pages/register/pag_register.dart';
import 'package:provider/provider.dart';

void main() => runApp(const LaudoEz());

class LaudoEz extends StatefulWidget {
  const LaudoEz({Key? key}) : super(key: key);

  @override
  _LaudoEzState createState() => _LaudoEzState();
}

class _LaudoEzState extends State<LaudoEz> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        title: 'Laudo Fácil',
        // home: RegisterFormPage()
        home: const LoginOrHomepage()
      );
  }
}