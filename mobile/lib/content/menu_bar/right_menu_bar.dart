import 'package:flutter/material.dart';
import '../../pages/config/about.dart';

class RightMenuBar extends StatefulWidget {
  const RightMenuBar({Key? key}) : super(key: key);

  @override
  _RightMenuBarState createState() => _RightMenuBarState();
}

class _RightMenuBarState extends State<RightMenuBar> {

  _itemBar(int valor, String titulo){
    return PopupMenuItem(
      value: valor,
      child: Text(titulo),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: Offset(0, 55),
      // color: Colors.black54,
      icon: Icon(Icons.more_vert),
      itemBuilder: (_) => <PopupMenuEntry>[
        _itemBar(1, 'Ajuda'),
        _itemBar(2, 'Configurações'),
        _itemBar(3, 'Sair')
      ],
      onSelected: (selectValue) {
        if(selectValue == 2){
          Navigator.push(
            context,
            MaterialPageRoute(builder: ((context) => ConfigPage()))
          );
          print('Você escolheu a opção Configurações');
        }else if(selectValue == 1){
          print('Você escolheu a opção Ajuda!');
        }else{
          print('Você escolheu a opção Sair');
        }
      } ,
    );
  }
}
