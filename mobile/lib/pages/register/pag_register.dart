import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../../constructor/user.dart';

class RegisterFormPage extends StatefulWidget {
  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  final _formkey = GlobalKey<FormState>();

  final _authData = AuthData();

  final firstPwdController = TextEditingController();

  final secoundPwdController = TextEditingController();

  _dataNascimento(){
    DateFormat("dd/MM/yyyy").format(_authData.dataNascimento!).toString();
  }

  _textFieldPersonal(String key, String info1, info2, String text) {
    return TextFormField(
      key: ValueKey(key),
      onChanged: (info1) => info2 = info1,
      decoration: InputDecoration(labelText: text),
      );
  }

  void comparePwd() {
    if(firstPwdController != secoundPwdController) {
      print("As senhas devem ser semelhantes");
    }
  }

  @override
  void dispose() {
    firstPwdController.dispose();
    secoundPwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 15,
              color: Colors.grey[150],
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      _textFieldPersonal('name', 'name', _authData.name, "Nome"),
                      DateTimeField(
                        key: const ValueKey('dataNascimento'),
                        format: DateFormat("dd/MM/yyyy"),
                        decoration: const InputDecoration(
                          labelText: 'Data de Nascimento',
                          hintText: 'dd/MM/aaaa'
                        ),
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                            context: context, 
                            initialDate: currentValue ?? DateTime.now(),
                            firstDate: DateTime(1899),
                            lastDate: DateTime(2100) 
                          );
                        },
                        onSaved: (dataNascimento) => _dataNascimento()[0] = dataNascimento,
                      ),
                      _textFieldPersonal('endereco', 'post', _authData.endereco, "Endereço"),
                      _textFieldPersonal('uf', 'uf', _authData.uf, "UF"),
                      _textFieldPersonal('cidade', 'city', _authData.cidade, "Cidade"),
                      _textFieldPersonal('bairro', 'bairro', _authData.bairro, "Bairro"),
                      _textFieldPersonal('numero', 'number', _authData.numero, "Número para Contato"),
                      _textFieldPersonal('email', 'email', _authData.email, "E-mail")
                    ],
                  ),
                ),
              )
            ),
            Card(
              elevation: 15,
              color: Colors.grey[150],
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Senha"),
                        obscureText: true,
                        controller: firstPwdController
                      ),
                      TextFormField(
                        key: const ValueKey('password'),
                        obscureText: true,
                        decoration: const InputDecoration(labelText: "Confirmar Senha"),
                        controller: secoundPwdController,
                      )
                    ],
                  ),
                )
              )
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Registrar',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}