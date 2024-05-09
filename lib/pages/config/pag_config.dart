import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: const Color.fromARGB(250, 250, 255, 255),
          title: const Text(
            'ATENÇÃO!',
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Para desligar as notificações, é preciso alterar as configurações de sistema. Clique em "CONFIRMAR" para continuar!',
            textAlign: TextAlign.center,
            ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  backgroundColor: const Color.fromRGBO(85, 212, 237, 93),
                ),
                onPressed: openAppSettings,
                child: const Text(
                  'Confirmar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  )
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
