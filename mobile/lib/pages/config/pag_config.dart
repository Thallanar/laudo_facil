
import 'package:flutter/material.dart';

// import 'package:flutter/rendering.dart';

String choiceDropdown = 'Color 1';

class ConfigPage extends StatefulWidget {
  const ConfigPage({ Key? key }) : super(key: key);

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
        style: const TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  _fontes<Object>(String valor, String texto, double tamanho) {
    return DropdownMenuItem(
      value: valor,
      child: Center(
        child: Text(
          texto,
          style: TextStyle(fontSize: tamanho),
          textAlign: TextAlign.center
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
                constraints: const BoxConstraints(maxHeight: 20, maxWidth: 40),
                decoration: BoxDecoration(
                  border: Border.all(style: BorderStyle.solid),
                  color: cor,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(85, 212, 237, 93),
        centerTitle: true,
        title: const Text('Configurações'),
      ),
      body: ListView(
        children: [
          _divisoes('<Temas>', 20),
          Card(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            child: ListTile(
              title: const Text(
                'Cor Tema',
              ),
              leading: const Icon(Icons.color_lens),
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
              margin: const EdgeInsets.only(bottom: 5),
              child: ListTile(
                  title: const Text('Tamanho da Fonte'),
                  leading: const Icon(Icons.text_format),
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
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            child: ListTile(
              title: const Text('Notificações'),
              leading: const Icon(Icons.notifications),
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
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            child: ListTile(
              title: const Text('Autenticação'),
              leading: const Icon(Icons.lock),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: (){},
            ),
          ),
          Card(
            margin: const EdgeInsets.only(bottom: 5),
            child: ListTile(
              title: const Text('Normas de Privacidade'),
              leading: const Icon(Icons.privacy_tip_outlined),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: (){}
            ),
          )
        ],
      ),
    );
  }
}
