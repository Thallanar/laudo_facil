import 'package:flutter/material.dart';

class Paciente {
  final String nome;
  final String numero;
  final DateTime dataNascimento;
  final String email;
  final String endereco;
  final String uf;
  final String cidade;
  final String bairro;
  final AssetImage photo;
  final int id;

  Paciente({
    required this.nome,
    required this.numero,
    required this.dataNascimento,
    required this.email,
    required this.endereco,
    required this.uf,
    required this.cidade,
    required this.bairro,
    required this.photo,
    required this.id
  });
}