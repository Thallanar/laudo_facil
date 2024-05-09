import 'package:flutter/material.dart';

import '../../pages/config/pag_config.dart';
import '../../models/auth/auth_service.dart';

class RightMenuBar extends StatefulWidget {
  const RightMenuBar({super.key});

  @override
  _RightMenuBarState createState() => _RightMenuBarState();
}

class _RightMenuBarState extends State<RightMenuBar> {

  _itemBar(int valor, String titulo, onTap){
    return PopupMenuItem(
      value: valor,
      onTap: onTap,
      child: Text(titulo),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (_) => <PopupMenuEntry>[
        _itemBar(1, 'Ajuda', (){}),
        _itemBar(2, 'Configurações', (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: ((context) => ConfigPage()))
          );
        }),
        _itemBar(3, 'Sair', (){ AuthService().logout(); })
      ],
    );
  }
}
