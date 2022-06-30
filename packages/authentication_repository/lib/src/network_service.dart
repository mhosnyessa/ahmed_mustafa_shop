import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import './authentication_repository.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  Map<String, dynamic> returnedObj = {
    'auth_status': AuthenticationStatus.unknown,
    'response': {
      'name': null,
      'email': null,
      'username': null,
      'password': null,
    }
  };
  Future<AuthenticationStatus> userLoginRequest(
      String email, String password) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return AuthenticationStatus.authenticated;
    } on FirebaseAuthException catch (e) {
      print('error code from firebase exception : ' + e.toString());
      return AuthenticationStatus.unauthenticated;
    }
  }

  Future<AuthenticationStatus> userSignupRequest({
    required String fullname,
    required String email,
    required String username,
    required String password,
    required String repeatPassword,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('authenticated');
      return AuthenticationStatus.authenticated;
    } on FirebaseAuthException catch (e) {
      var message = e;
      print('\n\n\n\n\n firebase exception : ' +
          message.toString() +
          '\n\n\n\n\n');
    } catch (e) {
      print('firebase catch e : ' + e.toString());
    }
    return AuthenticationStatus.unauthenticated;
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
