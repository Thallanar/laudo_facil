import 'package:flutter/material.dart';

import 'package:laudo_ez/constructor/paciente.dart';

final paciente = [
    Paciente(
    nome: 'André Luiz Gomes',
    numero: '(24) 99992-7303 / (24) 3347-3975',
    dataNascimento: DateTime(1996, 04, 30),
    email: 'aluizgomes@terra.com.br',
    endereco: 'Rua Sady Felipe, nº 106',
    uf: 'Rio de Janeiro',
    cidade: 'Volta Redonda',
    bairro: 'Morada da Colina',
    photo: const AssetImage('assets/pictures/example.jpg'),
    id: 0001
  )
  // Paciente(
  //   nome: 'Déborah Fernandes de Araujo',
  //   numero: '(24) 99313-4881 / NULL',
  //   dataNascimento: DateTime(1995, 02, 11),
  //   email: 'deefaraujo@gmail.com',
  //   endereco: 'Rua Lais Neto dos Reis, nº 276',
  //   uf: 'Rio de Janeiro',
  //   cidade: 'Resende',
  //   bairro: 'Vila Julieta',
  //   photo: AssetImage('assets/photo/foto_debah.jpeg'),
  //   id: 0004
  // ),
];
