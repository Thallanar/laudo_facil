import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  _socialLoginIcons(FaIcon icon, String socialMedia) {
    return IconButton(
      onPressed: () {},
      icon: icon,
      tooltip: socialMedia,
    );
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
                  child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Login: '),
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Senha: '),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        print('você tentou entrar');
                      },
                      child: const Text('Entrar'),
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text('Esqueci minha senha')),
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
                    color: Colors.grey[500]
                    ),
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
            _socialLoginIcons(
                const FaIcon(FontAwesomeIcons.instagram), 'Instagram'),
            _socialLoginIcons(
                const FaIcon(FontAwesomeIcons.twitter), 'Twitter'),
            _socialLoginIcons(
                const FaIcon(FontAwesomeIcons.apple), 'ID Apple'),    
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              // margin: const EdgeInsets.only(bottom: 70),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Não possui uma conta?'),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Criar Conta',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                      ),
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
