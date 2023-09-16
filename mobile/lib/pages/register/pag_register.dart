import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constructor/user.dart';

class RegisterFormPage extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final _authData = AuthData();

  _dataNascimento(){
    return DateFormat("dd/MM/yyyy").format(_authData.dataNascimento!).toString();
  }

  _textField(String key, String info1, info2, String text) {
    return TextFormField(
      key: ValueKey(key),
      onChanged: (info1) => info2 = info1,
      decoration: InputDecoration(labelText: text),
      );
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
                      _textField('name', 'name', _authData.name, "Nome"),
                      _textField('dataNascimento', 'dataNascimento', _authData.dataNascimento, "Data de Nascimento"),
                      _textField('endereco', 'post', _authData.endereco, "Endereço"),
                      _textField('uf', 'uf', _authData.uf, "UF"),
                      _textField('cidade', 'city', _authData.cidade, "Cidade"),
                      _textField('bairro', 'bairro', _authData.bairro, "bairro"),
                      _textField('numero', 'number', _authData.email, "Número"),
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
                  key: _formkey,
                  child: Column(
                    children: [
                     _textField('password', 'pwd', _authData.password, 'Senha'),
                     _textField('confirmacao', 'confirm', _authData.password, 'Confirmar Senha'),
                    ],
                  ),
                )
              )
            )
          ],
        ),
      ),
    );
  }
}