import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../../constructor/user.dart';

class RegisterForm extends StatefulWidget {
  final void Function(AuthData) onSubmit;
  final void Function(File image) onImagePick;

  const RegisterForm( {
    Key? key, required this.onSubmit, 
    required this.onImagePick 
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  File? _image;
  
  final _formKey = GlobalKey<FormState>();

  final _authData = AuthData();

  final firstPwdController = TextEditingController();

  final secoundPwdController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: 100
    );

    if(pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }

    widget.onImagePick(_image!);
  }

  Future _onSubmit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if(!isValid) return;
    widget.onSubmit(_authData);
  }

  Future<void> _photoPermission() async {
     await Permission.photos.request();
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
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: const Color.fromRGBO(85, 212, 237, 93),
                        foregroundImage: _image != null ? FileImage(_image!) : null,
                        child: IconButton(
                          icon: const Icon(Icons.image_search_outlined),
                          iconSize: 40,
                          onPressed: () async {
                            _photoPermission();
                            
                            if (await Permission.photos.isGranted) {
                              _pickImage();
                            }
                          },
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
                        initialValue: _authData.numero,
                        onChanged: (numero) => _authData.numero = numero,
                        decoration: const InputDecoration(
                          labelText: 'Número',
                          hintText: '(xx) xxxxx-xxxx'
                        ),
                      ),

                      TextFormField(
                        key: const ValueKey('email'),
                        initialValue: _authData.email,
                        onChanged: (email) => _authData.email = email,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          hintText: 'exemplo@exemplo.com'
                        ),
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
                    _pickImage();
                    print('${_authData.name} ${_authData.dataNascimento}');
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