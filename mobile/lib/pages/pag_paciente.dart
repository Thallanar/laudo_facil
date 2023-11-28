import 'package:flutter/material.dart';
import 'package:laudo_ez/content/menu_bar/right_menu_bar.dart';


class PagPaciente extends StatefulWidget {
  const PagPaciente({Key? key}) : super(key: key);

  @override
  _PagPacienteState createState() => _PagPacienteState();
}

class _PagPacienteState extends State<PagPaciente> {
  _cardInfo(String texto, content){
    return Card(
      child: ListTile(
        leading: Text(texto),
        title: Text(content, textAlign: TextAlign.end),
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
      body: ListView(
        children: const [Center(
          child: Column(
            children: [
              // Column(
              //     children: paciente.map((pa) => Container(
              //       padding: EdgeInsets.only(top: 30),
              //       child: CircleAvatar(
              //         radius: 100,
              //         foregroundImage: pa.photo
              //         ),
              //       ),
              //     ).toList()),
              SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                    children: [
                      // _cardInfo('Nome:', pa.login),
                      // _cardInfo('Data de Nascimento:', DateFormat("dd/MM/yyyy").format(paciente.dataNascimento)),
                      // _cardInfo('Telefone:', pa.numero),
                      // _cardInfo('e-mail:', pa.email),
                      // _cardInfo('Endereço:', pa.endereco), 
                      // _cardInfo('Bairro:', pa.bairro),
                      // _cardInfo('Cidade:', pa.cidade), 
                      // _cardInfo('UF:', pa.uf)
                    ],
                  )),
            ],
          ),
        ),]
      ),
    );
  }
}
