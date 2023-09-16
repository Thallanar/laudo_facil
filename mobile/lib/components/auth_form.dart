import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constructor/user.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData) onSubmit;

  const AuthForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _authData = AuthData();

  Future _showLoginError(String txt, String msg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            txt,
            style: const TextStyle(
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'), 
              child: const Text('OK')
            )
          ],
        );
      }
    );
  }

  _socialLoginIcons(FaIcon icon, String socialMedia) {
    return IconButton(
      onPressed: () {},
      icon: icon,
      tooltip: socialMedia,
    );
  }

  Future _onSubmit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if(!isValid) return;

    if(_authData.email == null && _authData.isSingUp) {
      return _showLoginError('Campo Obrigatório!', 'Os campos e-mail e senha são obrigatórios!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
            elevation: 15,
            color: Colors.grey[150],
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                children: [
                  TextFormField(
                    key: const ValueKey('email'),
                    initialValue: _authData.email,
                    onChanged: (email) => _authData.email = email,
                    decoration: const InputDecoration(labelText: 'Login: '),
                    validator: (mail) {
                      final email = mail ?? '';
                      if(!email.contains('@')) {
                        return 'E-mail inválido!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    initialValue: _authData.password,
                    onChanged: (password) => _authData.password = password,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Senha: '),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        _onSubmit();
                        print('você tentou entrar ${_authData.email} ${_authData.password}');
                      },
                      child: const Text('Entrar'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Esqueci minha senha!')),
                ],
              )),
            )),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Entrar com',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.grey[500]),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialLoginIcons(
                const FaIcon(FontAwesomeIcons.facebook), 'Facebook'),
            _socialLoginIcons(const FaIcon(FontAwesomeIcons.google), 'G-Mail'),
            _socialLoginIcons(const FaIcon(FontAwesomeIcons.instagram), 'Instagram'),
            _socialLoginIcons(const FaIcon(FontAwesomeIcons.twitter), 'X'),
            _socialLoginIcons(const FaIcon(FontAwesomeIcons.apple), 'ID Apple'),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              // margin: const EdgeInsets.only(bottom: 70),
              child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    const Text('Não possui uma conta?'),
                    TextButton(
                      onPressed: () => setState(() {
                        _authData.toggleAuthMode();
                      }),
                      child: const Text(
                        'Criar Conta',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
            ),
          ],
        )
      ],
    );
  }
}
