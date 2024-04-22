import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:laudo_ez/components/auth_form.dart';
import '../../constructor/user.dart';

class RegisterForm extends StatefulWidget {
  final void Function(AuthData) onSubmit;

  const RegisterForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final _authData = AuthData();

  final firstPwdController = TextEditingController();

  final secoundPwdController = TextEditingController();

  Future _onSubmit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if(!isValid) return;
    widget.onSubmit(_authData);
  }

  _dataNascimento(){
    DateFormat("dd/MM/yyyy").format(_authData.dataNascimento!).toString();
  }

  _textFieldPersonal(String key, info2, String text, String hint) {
    return TextFormField(
      key: ValueKey(key),
      initialValue: info2,
      onChanged: (key) => info2 = key,
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
                      // _textFieldPersonal('name', _authData.name, "Nome", 'Insira seu nome'),
                      TextFormField(
                        key: const ValueKey('name'),
                        initialValue: _authData.name,
                        onChanged: (name) => _authData.name = name,
                        // obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Nome Completo',
                          hintText: 'Escreva seu nome',
                          ),
                      ),
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
                        onSaved: (dataNascimento) => _authData.dataNascimento = dataNascimento,
                      ),
                      TextFormField(
                        key: const ValueKey('email'),
                        initialValue: _authData.email,
                        onChanged: (email) => _authData.email = email,
                        // obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          hintText: 'exemplo@exemplo.com',
                          ),
                      ),
                      // _textFieldPersonal('endereco', _authData.endereco, "Endereço", 'Rua, número, complemento (se houver)'),
                      // _textFieldPersonal('uf', _authData.uf, "UF", ''),
                      // _textFieldPersonal('cidade', _authData.cidade, "Cidade", ''),
                      // _textFieldPersonal('bairro', _authData.bairro, "Bairro", ''),
                      // _textFieldPersonal('numero', _authData.numero, "Número para Contato", '(xx) xxxxx-xxxx'),
                      // _textFieldPersonal('email', _authData.email, "E-mail", 'exemplo@exemplo.com')
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
                        key: const ValueKey('password'),
                        obscureText: true,
                        onChanged: (password) => _authData.password = password,
                        // controller: firstPwdController
                        decoration: const InputDecoration(labelText: "Senha"),
                      ),
                      // TextFormField(
                      //   key: const ValueKey('password'),
                      //   obscureText: true,
                      //   decoration: const InputDecoration(labelText: "Confirmar Senha"),
                      //   controller: secoundPwdController,
                      //   onChanged: (senha) {
                      //     comparePwd();
                      //   },
                      // )
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
                    _onSubmit();
                    print('${_authData.name}');
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
        );
  }
}