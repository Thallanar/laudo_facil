import 'package:flutter/material.dart';

import '../provider/login_or_hamepage.dart';
import '../../components/register_form.dart';
import '../../models/auth/auth_service.dart';
import '../../constructor/user.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  Future<void> _handleSubmit(AuthData authData) async {
    return await AuthService().signup(
      authData.name,
      authData.numero, 
      authData.dataNascimento!,
      authData.email,
      authData.endereco!,
      authData.uf!,
      authData.cidade!,
      authData.bairro!,
      authData.picture,
      
      authData.password,
    );
  }

  _registerPageState() {
    return Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Center(
              child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: RegisterForm(onSubmit: _handleSubmit),
          )),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        backgroundColor: const Color.fromRGBO(85, 212, 237, 93),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginOrHomepage()
            ) 
          )
        ),
      ),
      body: _registerPageState(),
    );
  }
}