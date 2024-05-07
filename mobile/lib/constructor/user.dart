import 'dart:io';

enum AuthMode { SingUp, Login }


class AppUser {
  final String id;
  final String? name;
  final String? numero;
  final DateTime? dataNascimento;
  final String? email;
  final String? endereco;
  final String? uf;
  final String? cidade;
  final String? bairro;
  final String imageURL;

  final String? password;

    const AppUser({
      required this.id,
      required this.name,
      required this.numero,
      required this.dataNascimento,
      required this.email,
      required this.endereco,
      required this.uf,
      required this.cidade,
      required this.bairro,
      required this.imageURL,

      required this.password,
    });
}

class AuthData {
  String name = '';
  String? numero;
  DateTime? dataNascimento;
  String? email = '';
  String? endereco = '';
  String? uf = '';
  String? cidade = '';
  String? bairro = '';
  File? picture;

  String? password = '';
  AuthMode _mode = AuthMode.Login;

  bool get isLogin {
    return _mode == AuthMode.Login;
  }

  bool get isSingUp {
    return _mode == AuthMode.SingUp;
  }

  void toggleAuthMode() {
    _mode = isLogin ? AuthMode.SingUp : AuthMode.Login;
  }
}