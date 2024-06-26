import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../constructor/user.dart';

abstract class AuthService {
  AppUser? get authData;

  Stream<AppUser?> get dataChanges;

  Future<void> signup(
    String? name,
    String? numero,
    DateTime? dataNascimento,
    String? email,
    String? endereco,
    String? uf,
    String? cidade,
    String? bairro,
    File? picture,

    String? password,
  );

  Future<void> login(
    String? email,
    String? password,
  );

  Future<void> logout();

  factory AuthService() {
    return AuthFirebaseService();
  }

  Future<User?> googleLogin();

  Future<User?> facebookLogin(); 
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
    String? name,
    String? numero,
    DateTime? dataNascimento,
    String? email,
    String? endereco,
    String? uf,
    String? cidade,
    String? bairro,
    File? picture,

    String? password,
  ) async {
    final auth = FirebaseAuth.instance;
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email!, 
      password: password!
    );

    if(credential.user == null) return;

    // Resgatando foto de usuário
    final imageName = '${credential.user!.uid}.jpg';
    final imageURL = await _uploadUserImage(picture, imageName);

    // Atualizando informações do usuário
    await credential.user?.updateDisplayName(name);
    await credential.user?.updatePhotoURL(imageURL);

    // Salavando usuário no banco (ainda não implementado)
    _authData = _toAuthData(
      credential.user!,
      name, 
      email,
      numero, 
      dataNascimento, 
      endereco,
      uf,
      cidade,
      bairro,
      imageURL,
      password
    );

    print(_authData?.imageURL);
    await _saveAuthData(_authData!);
    
  }

  @override
  Future<void> login(
      String? email,
      String? password
    ) async {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!, 
        password: password!
      );
    }

  @override
  Future<User?> googleLogin() async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;
      
      return user;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<User?> facebookLogin() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FacebookAuth facebookAuth = FacebookAuth.instance;

    try {
      // Inicia o processo de login com o Facebook
      final LoginResult result = await facebookAuth.login(
        permissions: ['email', 'public_profile'],
        loginBehavior: LoginBehavior.nativeWithFallback
      );

      // Verifica se o login foi bem-sucedido
      if (result.status == LoginStatus.success) {
        // Obtém o token de acesso do Facebook
        final AccessToken accessToken = result.accessToken!;

        // Cria as credenciais de autenticação do Facebook
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        // Autentica com o Firebase usando as credenciais do Facebook
        UserCredential authResult =
            await _auth.signInWithCredential(credential);
        final User? user = authResult.user;

        return user;
      } else {
        print("não foi possível encontrar o facebook");
        return null;
      }
    } catch (error) {
      print("não foi possível encontrar o facebook");
      return null;
    }
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String?> _uploadUserImage(File? image, String imageName) async {
    if (image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('user_images').child(imageName);
    await imageRef.putFile(image);
    return await imageRef.getDownloadURL();
  }

  Future<void> _saveAuthData(AppUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);

    return docRef.set({
      'name': user.name,
      'email': user.email,
      'numero': user.numero, 
      'dataNascimento': user.dataNascimento, 
      'endereco': user.endereco,
      'uf': user.uf,
      'cidade': user.cidade,
      'bairro': user.bairro,
      'imageURL': user.imageURL
    });
  }

  static AppUser _toAuthData(
    User user, [
      String? name,
      String? email,
      String? numero,
      DateTime? dataNascimento,
      String? endereco,
      String? uf,
      String? cidade,
      String? bairro,
      String? imageURL,

      String? password,
  ]){
    return AppUser(
      id: user.uid,
      name: name ?? user.displayName ?? user.email!.split('@')[0], 
      numero: numero,
      dataNascimento: dataNascimento, 
      email: user.email, 
      endereco: endereco, 
      uf: uf, 
      cidade: cidade, 
      bairro: bairro,
      imageURL: imageURL ?? user.photoURL ?? 'assets/pictures/example.jpg',

      password: password, 
    );
  }
}