
import 'package:flutter/material.dart';

// import 'package:flutter/rendering.dart';

String choiceDropdown = 'Color 1';

class ConfigPage extends StatefulWidget {
  // const ConfigPage({ Key? key }) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {

  String choiceDropdown = 'Color 1';

  String choiceDropdownFont = 'FontSize 1';
  
  bool _value = false;

  void _onChanged(bool value){
    setState((){
      _value = value;
    });
  }
  
  _divisoes(String texto, double espacamento) {
    return Container(
      margin: EdgeInsets.only(top: espacamento),
      child: Text(
        texto,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }

  _fontes<Object>(String valor, String texto, double tamanho) {
    return DropdownMenuItem(
      value: valor,
      child: Container(
        child: Center(
          child: Text(
            texto,
            style: TextStyle(fontSize: tamanho),
            textAlign: TextAlign.center
          ),
        ),
      )
    );
  }

  _themeColor<Object>(String valor, cor) {
    return DropdownMenuItem(
        value: valor,
        child: FittedBox(
            fit: BoxFit.fill,
            child: Container(
                constraints: BoxConstraints(maxHeight: 20, maxWidth: 40),
                decoration: BoxDecoration(
                  border: Border.all(style: BorderStyle.solid),
                  color: cor,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        centerTitle: true,
        title: Text('Configurações'),
      ),
      body: ListView(
        children: [
          _divisoes('<Temas>', 20),
          Card(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: ListTile(
              title: Text(
                'Cor Tema',
              ),
              leading: Icon(Icons.color_lens),
              trailing: DropdownButton<String>(
                value: choiceDropdown,
                onChanged: (value) {
                        setState(() {
                          choiceDropdown = value!;
                        });
                      },
                items: [
                  _themeColor('Color 1', Colors.orange),
                  _themeColor('Color 2', Colors.blue),
                  _themeColor('Color 3', Colors.grey[800]),
                  _themeColor('Color 4', Colors.purple[900]),
                  _themeColor('Color 5', Colors.green[900])
                ],
              ),
            ),
          ),
          Card(
              margin: EdgeInsets.only(bottom: 5),
              child: ListTile(
                  title: Text('Tamanho da Fonte'),
                  leading: Icon(Icons.text_format),
                  trailing: DropdownButton<String>(
                    value: choiceDropdownFont,
                    onChanged: (value) {
                      setState(() {
                        choiceDropdownFont = value!;
                      });
                    },
                    items: [
                      _fontes('FontSize 1', 'Pequeno', 15),
                      _fontes('FontSize 2', 'Médio', 22),
                      _fontes('FontSize 3', 'Grande', 30)
                    ],
                  )
                )
            ),
          _divisoes('<Sistema>', 15),
          Card(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: ListTile(
              title: Text('Notificações'),
              leading: Icon(Icons.notifications),
              trailing: Switch(
                activeColor: Colors.green,
                value: _value,
                onChanged: (bool value) {
                  _onChanged(value);
                },
              ),
            ),
          ),
          _divisoes('<Segurança>', 15),
          Card(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: ListTile(
              title: Text('Autenticação'),
              leading: Icon(Icons.lock),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: (){},
            ),
          ),
          Card(
            margin: EdgeInsets.only(bottom: 5),
            child: ListTile(
              title: Text('Normas de Privacidade'),
              leading: Icon(Icons.privacy_tip_outlined),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: (){}
            ),
          )
        ],
      ),
    );
  }
}
