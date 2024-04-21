import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:laudo_ez/components/auth_form.dart';

import '../../constructor/user.dart';
import '../../models/auth/auth_service.dart';

class RegisterFormPage extends StatefulWidget {
  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  final _formkey = GlobalKey<FormState>();

  final _authData = AuthData();

  final firstPwdController = TextEditingController();

  final secoundPwdController = TextEditingController();

  bool _isLoading = false;

  _dataNascimento(){
    DateFormat("dd/MM/yyyy").format(_authData.dataNascimento!).toString();
  }

  _textFieldPersonal(String key, String info1, info2, String text, String hint) {
    return TextFormField(
      key: ValueKey(key),
      initialValue: info2,
      onChanged: (_) => info2 = info1,
      decoration: InputDecoration(
        labelText: text,
        hintText: hint
      ),
    );
  }

  void comparePwd() {
    if(firstPwdController != secoundPwdController) {
      print("As senhas devem ser semelhantes");
    }
  }

  @override
  void dispose() {
    firstPwdController.dispose();
    secoundPwdController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit(AuthData authData) async {
    try {
      if(!mounted) return;
      setState(() => _isLoading = true);

      if(authData.isLogin) {
        await AuthService().signup(
          authData.email!,
          authData.password!,
          authData.dataNascimento!,
          authData.bairro!,
          authData.name, 
          authData.numero!, 
          authData.endereco!,
          authData.uf!,
          authData.cidade!
        );
      }
    }catch(error) {
      print(error.toString());
    }finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        backgroundColor: const Color.fromRGBO(85, 212, 237, 93),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 15,
              color: Colors.grey[150],
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      _textFieldPersonal('name', 'name', _authData.name, "Nome", 'Insira seu nome'),
                      DateTimeField(
                        key: const ValueKey('dataNascimento'),
                        autocorrect: true,
                        format: DateFormat("dd/MM/yyyy"),
                        decoration: const InputDecoration(
                          labelText: 'Data de Nascimento',
                          hintText: 'dd/MM/aaaa'
                        ),
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                            context: context, 
                            initialDate: currentValue ?? DateTime.now(),
                            firstDate: DateTime(1899),
                            lastDate: DateTime(2100) 
                          );
                        },
                        onSaved: (dataNascimento) => _dataNascimento()[0] = dataNascimento,
                      ),
                      _textFieldPersonal('endereco', 'endereco', _authData.endereco, "Endereço", 'Rua, número, complemento (se houver)'),
                      _textFieldPersonal('uf', 'uf', _authData.uf, "UF", ''),
                      _textFieldPersonal('cidade', 'city', _authData.cidade, "Cidade", ''),
                      _textFieldPersonal('bairro', 'bairro', _authData.bairro, "Bairro", ''),
                      _textFieldPersonal('numero', 'number', _authData.numero, "Número para Contato", '(xx) xxxxx-xxxx'),
                      _textFieldPersonal('email', 'email', _authData.email, "E-mail", 'exemplo@exemplo.com')
                    ],
                  ),
                ),
              )
            ),
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
                        decoration: const InputDecoration(labelText: "Senha"),
                        obscureText: true,
                        controller: firstPwdController
                      ),
                      TextFormField(
                        key: const ValueKey('password'),
                        obscureText: true,
                        decoration: const InputDecoration(labelText: "Confirmar Senha"),
                        controller: secoundPwdController,
                        onChanged: (senha) {
                          comparePwd();
                        },
                      )
                    ],
                  ),
                )
              )
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: ElevatedButton(
                  onPressed: () {
                    AuthForm(onSubmit: _handleSubmit);
                    print(_authData.email);
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Color.fromRGBO(85, 212, 237, 93)),
                  ),
                  child: const Text(
                    'Registrar',
                    style: TextStyle(
                      fontSize: 15,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black
                      ),        
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}