import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constructor/user.dart';

abstract class AuthService {
  AppUser? get authData;

  Stream<AppUser?> get dataChanges;

  Future<void> signup(
    String name,
    String numero,
    DateTime? dataNascimento,
    String? email,
    String endereco,
    String uf,
    String cidade,
    String bairro,
    String id,

    String password,
  );

  Future<void> login(
    String email,
    String password,
  );

  Future<void> logout();

  factory AuthService() {
    return AuthFirebaseService();
  }
}

// Firebase Auth
class AuthFirebaseService implements AuthService {
  static AppUser? _authData;

  static final _userStream = Stream<AppUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _authData = user == null ? null : _toAuthData(user);
      controller.add(_authData);
    }
  });

  @override
  AppUser? get authData {
    return _authData;
  }

  @override
  Stream<AppUser?> get dataChanges {
    return _userStream;
  }

  @override
  Future<void> signup(
    String name,
    String numero,
    DateTime? dataNascimento,
    String? email,
    String endereco,
    String uf,
    String cidade,
    String bairro,
    String id,

    String password,
  ) async {
    final auth = FirebaseAuth.instance;
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email!, 
      password: password
    );

    if(credential.user == null) return;

    // Atualizando informações do usuário
    await credential.user?.updateDisplayName(name);  

    //Salavando usuário no banco (ainda não implementado)
    _authData = _toAuthData(
      credential.user!, 
      name, 
      numero, 
      dataNascimento!, 
      endereco,
      uf,
      cidade,
      bairro,
    );

    await _saveAuthData(_authData!);
  }

  @override
  Future<void> login(
      String? email,
      String password
    ) async {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!, 
        password: password
      );
    }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  Future<void> _saveAuthData(AppUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);

    return docRef.set({
      'name': user.name,
      'email': user.email!,
      'numero': user.numero, 
      'dataNascimento': user.dataNascimento!, 
      'endereco': user.endereco,
      'uf': user.uf,
      'cidade': user.cidade,
      'bairro': user.bairro,
    });
  }

  static AppUser _toAuthData(
    User user, [
      String? name,
      String? numero,
      DateTime? dataNascimento,
      String? endereco,
      String? uf,
      String? cidade,
      String? bairro,

      String? password,
  ]){
    return AppUser(
      name: name ?? user.displayName ?? user.email!.split('@')[0], 
      numero: numero ?? user.phoneNumber!,
      dataNascimento: dataNascimento!, 
      email: user.email!, 
      endereco: endereco!, 
      uf: uf!, 
      cidade: cidade!, 
      bairro: bairro!,

      password: password!, 
      id: user.uid, 
    );
  }
}