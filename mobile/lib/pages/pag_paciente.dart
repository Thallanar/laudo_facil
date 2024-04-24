import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laudo_ez/content/menu_bar/right_menu_bar.dart';
import 'package:laudo_ez/models/auth/auth_service.dart';

import '../constructor/user.dart';

class PagPaciente extends StatefulWidget {
  const PagPaciente({Key? key}) : super(key: key);

  @override
  _PagPacienteState createState() => _PagPacienteState();
}

class _PagPacienteState extends State<PagPaciente> {
  final AuthService _authService = AuthService();

  _cardInfo(String texto, content) {
    return Card(
      child: ListTile(
        leading: Text(texto),
        title: Text(content ?? '', textAlign: TextAlign.end),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Minha Conta'),
        elevation: 10,
        backgroundColor: const Color.fromRGBO(85, 212, 237, 93),
      ),
      body: StreamBuilder<AppUser?>(
          stream: _authService.dataChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              final user = snapshot.data;
              return ListView(children: [
                Center(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundColor: Color.fromRGBO(85, 212, 237, 93),
                                  foregroundImage: user?.imageURL != null ? NetworkImage('${user!.imageURL}') : null,
                                ),
                              ),
                              _cardInfo('Nome:', user?.name),
                              _cardInfo('e-mail', user?.email),
                              _cardInfo('Data de Nascimento:', user?.dataNascimento),
                              _cardInfo('Telefone:', user?.numero),
                              _cardInfo('Endereço:', user?.endereco),
                              _cardInfo('Bairro:', user?.bairro),
                              _cardInfo('Cidade:', user?.cidade),
                              _cardInfo('UF:', user?.uf)
                            ],
                          )),
                    ],
                  ),
                ),
              ]);
            }
          }),
    );
  }
}
