
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

// import 'package:flutter/rendering.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({ Key? key }) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _updateState();
  }

  Future<void> _permissionState(bool value) async {
    await Permission.notification.request();

    if(!value) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => const AlertDialog(
          title: Text(
            'ATENÇÃO!',
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Para desligar as notificações, é preciso alterar as configurações de sistema. Clique em "CONFIRMAR" para continuar!',
            textAlign: TextAlign.justify,
            ),
          actions: [
            TextButton(
              onPressed: openAppSettings, 
              child: Card(
                // color: Colors.grey.shade300,
                elevation: 0,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Confirmar',
                    style: TextStyle(
                      color: Color.fromRGBO(85, 212, 237, 93),
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              )
            )
          ],
        )
      );
    } 

    setState(() {
      _value = value;
    });
    print(value);
  }

  Future<void> _updateState() async {
    var permissionStatus = await Permission.notification.status;

    if(permissionStatus.isGranted) {
      var permission = true;
      setState(() {
      _value = permission;
      });
    }

    print(permissionStatus);
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
          _divisoes('<Sistema>', 15),
          Card(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            child: ListTile(
              title: const Text('Notificações'),
              leading: const Icon(Icons.notifications),
              trailing: Switch(
                activeColor: Colors.green,
                value: _value,
                onChanged: _permissionState
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
