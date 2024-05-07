import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:laudo_ez/routes/routes.dart';

import 'package:laudo_ez/pages/provider/login_or_hamepage.dart';
import 'package:laudo_ez/pages/config/pag_config.dart';
import 'package:laudo_ez/pages/pag_paciente.dart';
import 'package:laudo_ez/pages/pag_consultas.dart';
import 'package:laudo_ez/pages/register/pag_register.dart';

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
        home: const LoginOrHomepage(),
        routes: {
          InnerPageRoutes.pag_config: (context) => const ConfigPage(),
          InnerPageRoutes.pag_consultas: (context) => const PagConsultas(),
          InnerPageRoutes.pag_paciente: (context) => const PagPaciente(),

          AuthPageRoutes.pag_register: (context) => const RegisterFormPage(),
          AuthPageRoutes.login_or_homepage: (context) => const LoginOrHomepage() 
        },
      );
  }
}    