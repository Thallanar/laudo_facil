import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

import 'package:laudo_ez/models/exames_dummy.dart';

class PagConsultas extends StatefulWidget {
  const PagConsultas({ Key? key }) : super(key: key);

  @override
  _PagConsultasState createState() => _PagConsultasState();
}

class _PagConsultasState extends State<PagConsultas> {

  var contador = 0;
  void _adcionarValor(){
    setState(() {
      contador++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        hoverElevation: 15,
        elevation: 0,
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.white
        ),
        onPressed: () {
          _adcionarValor(); 
          print(contador);
          if(contador >= 50){
            print('stop clicking, plz!');
          }
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Documentos'),
        backgroundColor: Colors.black54,
        elevation: 10,
      ),
      body: ListView(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Text('$contador')
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Card(
                        elevation: 15,
                        child: ListTile(
                          title: Text(
                            'Documento Exemplo',
                            textAlign: TextAlign.center,
                          ),
                          leading: TextButton(
                            onPressed: (){
                              exames.map((ex) => OpenFile.open('assets/image/foto_thais.png'));
                            },
                            child: Icon(
                              Icons.file_present_rounded,
                              color: Colors.black54,
                            )
                          ),
                          trailing: TextButton(
                            onPressed: (){},
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 15,
                            ),
                          )
                        )
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}