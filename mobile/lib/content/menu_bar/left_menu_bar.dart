import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';

import 'package:laudo_ez/pages/pag_consultas.dart';
import 'package:laudo_ez/pages/pag_historico.dart';
import 'package:laudo_ez/pages/pag_paciente.dart';
import 'package:laudo_ez/pages/pag_sobre.dart';

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
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
          color: Colors.black54,
          alignment: Alignment.center,
          child: Text(
            'Em Desenvolvimento',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
    );

    final drawerItens = Container(
      child: ListView(
        children: [
          drawerHeader,
          _drawerCardContent(Icons.account_circle_rounded, 'Minha Conta', PagPaciente()),
          _drawerCardContent(Icons.library_books_rounded, 'Consultas', PagConsultas()),
          _drawerCardContent(Icons.history, 'Histórico', HistoryPage()),
          _drawerCardContent(Icons.description_outlined, 'Sobre', PagSobre())
        ],
      ),
    );
    return Drawer(
      child: drawerItens,
      elevation: 25,
    );
  }
}
