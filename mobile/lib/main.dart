import 'package:flutter/material.dart';
import 'package:laudo_ez/pages/auth/auth_page.dart';
import 'package:laudo_ez/pages/homepage.dart';

void main() => runApp(LaudoEz());

class LaudoEz extends StatefulWidget {
  const LaudoEz({Key? key}) : super(key: key);

  @override
  _LaudoEzState createState() => _LaudoEzState();
}

class _LaudoEzState extends State<LaudoEz> {
  List<Color?> colorsList = [
    Colors.blue,
    Colors.green[900],
    Colors.grey[800],
    Colors.orange,
    Colors.purple[900]
  ];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        title: 'Laudo Fácil',
        // home: HomePage()
        home: AuthPage()
      );
  }
}