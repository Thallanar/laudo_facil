import 'dart:io';

import '../routes/routes.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../../constructor/user.dart';

class RegisterForm extends StatefulWidget {
  final void Function(AuthData) onSubmit;

  const RegisterForm( {
    Key? key, 
    required this.onSubmit, 
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  File? _image;
  
  final _formKey = GlobalKey<FormState>();

  final _authData = AuthData();

  final TextEditingController _phoneController = TextEditingController();

  final MaskTextInputFormatter _phoneFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####', 
    filter: { "#": RegExp(r'[0-9]') } 
  );

  Future<void> _pickImage() async {
    await Permission.photos.isGranted;
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if(pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _authData.picture = _image;
      });
    }
  }
  
  Future _onSubmit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if(!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: true, 
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(250, 250, 255, 255),
        icon: const Icon(
          Icons.check_circle_outlined,
          size: 50,
        ),
        iconColor: Colors.green,
        content: const Text(
          'Conta criada com sucesso',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pushReplacementNamed(AuthPageRoutes.login_or_homepage), 
            child: const Text('Ok')
          )
        ],
      )
    );

    widget.onSubmit(_authData);
  }

  bool isValidPassword(String password) {
    // Verifica se a senha contém pelo menos um número, uma letra maiúscula e um caractere especial
    RegExp digitRegex = RegExp(r'[0-9]');
    RegExp uppercaseRegex = RegExp(r'[A-Z]');
    RegExp specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    bool hasDigit = digitRegex.hasMatch(password);
    bool hasUppercase = uppercaseRegex.hasMatch(password);
    bool hasSpecialChar = specialCharRegex.hasMatch(password);

    return hasDigit && hasUppercase && hasSpecialChar;
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
                      Container(
                        margin: const EdgeInsets.only(bottom: 50, top: 30),
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: const Color.fromRGBO(85, 212, 237, 93),
                          foregroundImage: _image != null ? FileImage(_image!) : null,
                          child: IconButton(
                            icon: const Icon(Icons.image_search_outlined),
                            iconSize: 40,
                            onPressed: _pickImage
                          ),
                        ),
                      ),

                      TextFormField(
                        key: const ValueKey('name'),
                        initialValue: _authData.name,
                        onChanged: (name) => _authData.name = name,
                        decoration: const InputDecoration(
                          labelText: 'Nome Completo',
                          hintText: 'Escreva seu nome',
                          ),
                      ),

                      DateTimeField(
                        key: const ValueKey('dataNascimento'),
                        initialValue: _authData.dataNascimento,
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
                        onChanged: (dataNascimento) => _authData.dataNascimento = dataNascimento
                      ),

                      TextFormField(
                        key: const ValueKey('endereco'),
                        initialValue: _authData.endereco,
                        onChanged: (endereco) => _authData.endereco = endereco,
                        decoration: const InputDecoration(
                          labelText: 'Endereço',
                          hintText: 'Rua, numero e complemento (caso houver)',
                          ),
                      ),

                      TextFormField(
                        key: const ValueKey('bairro'),
                        initialValue: _authData.bairro,
                        onChanged: (bairro) => _authData.bairro = bairro,
                        decoration: const InputDecoration(
                          labelText: 'Bairro',
                          ),
                      ),

                      TextFormField(
                        key: const ValueKey('cidade'),
                        initialValue: _authData.cidade,
                        onChanged: (cidade) => _authData.cidade = cidade,
                        decoration: const InputDecoration(
                          labelText: 'Cidade',
                          hintText: 'Cidade onda mora',
                          ),
                      ),

                      TextFormField(
                        key: const ValueKey('uf'),
                        initialValue: _authData.uf,
                        onChanged: (uf) => _authData.uf = uf,
                        decoration: const InputDecoration(
                          labelText: 'UF',
                        ),
                      ),

                      TextFormField(
                        key: const ValueKey('numero'),
                        controller: _phoneController,
                        initialValue: _authData.numero,
                        onChanged: (numero) => _authData.numero = numero,
                        decoration: const InputDecoration(
                          labelText: 'Telefone',
                          hintText: '(xx) xxxxx-xxxx',
                        ),
                        inputFormatters: [ _phoneFormatter ],
                        validator: (number) {
                          if(number!.length > 11 && number.length < 10) {
                            return 'Número iválido';
                          }
                          return null;
                        },
                      ),

                      TextFormField(
                        key: const ValueKey('email'),
                        initialValue: _authData.email,
                        onChanged: (email) => _authData.email = email,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          hintText: 'exemplo@exemplo.com'
                        ),
                        validator: (email) {
                          if(!email!.contains('@')) {
                            return 'E-mail inválido';
                          }
                          return null;
                        },
                      ),
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
                        decoration: const InputDecoration(labelText: "Senha"),
                        validator: (password) {
                        if(password == null || password.isEmpty) {
                          return 'Senha é obrigatória!';
                        }
                        if(password.length < 6) {
                          return 'A senha deve conter pelo menos 6 caracteres!';
                        }
                        if (!isValidPassword(password)) {
                          return 'A senha deve conter pelo menos um número, uma letra maiúscula e um caractere especial!';
                        }
                          return null;
                        }
                      ),
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
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Color.fromRGBO(85, 212, 237, 93)),
                  ),
                  child: const Text(
                    'Registrar',
                    style: TextStyle(
                      fontSize: 15,
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