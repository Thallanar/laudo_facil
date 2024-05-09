import 'package:flutter/material.dart';

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
        backgroundColor: const Color.fromRGBO(85, 212, 237, 93),
        child: const Icon(
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
        title: const Text('Documentos'),
        backgroundColor: const Color.fromRGBO(85, 212, 237, 93),
        elevation: 10,
      ),
      body: ListView(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Card(
                        elevation: 15,
                        child: ListTile(
                          title: const Text(
                            'Documento Exemplo',
                            textAlign: TextAlign.center,
                          ),
                          leading: TextButton(
                            onPressed: (){},
                            child: const Icon(
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