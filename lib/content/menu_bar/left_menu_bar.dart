import 'package:flutter/material.dart';

import '../../pages/pag_consultas.dart';
import '../../pages/pag_historico.dart';
import '../../pages/pag_paciente.dart';
import '../../pages/pag_sobre.dart';

class LeftMenuBar extends StatefulWidget {
  const LeftMenuBar({Key? key}) : super(key: key);

  @override
  _MenuBarState createState() => _MenuBarState();
}
class _MenuBarState extends State<LeftMenuBar> {

  _drawerCardContent(icon, String texto, rota){
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(texto),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: ((context) => rota))
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final drawerHeader = DrawerHeader(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
          color: const Color.fromRGBO(85, 212, 237, 93),
          alignment: Alignment.center,
          child: const Text(
            'Em Desenvolvimento',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
    );

    final drawerItens = ListView(
      children: [
        drawerHeader,
        _drawerCardContent(Icons.account_circle_rounded, 'Minha Conta', const PagPaciente()),
        _drawerCardContent(Icons.library_books_rounded, 'Consultas', const PagConsultas()),
        _drawerCardContent(Icons.history, 'Histórico', const HistoryPage()),
        _drawerCardContent(Icons.description_outlined, 'Sobre', const PagSobre())
      ],
    );
    return Drawer(
      elevation: 25,
      child: drawerItens,
    );
  }
}
