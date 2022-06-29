import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

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
      String username, String password) async {
    var uri = Uri(
      scheme: 'https',
      host: 'ahmed-shop-b7546.firebaseapp.com/__/auth/action',
    );

    try {
      http.Response response = await http
          .post(uri, body: {"username": username, "password": password});

      switch (response.statusCode) {
        case 200:
          return AuthenticationStatus.authenticated;
          break;
        case 400:
          return AuthenticationStatus.unauthenticated;
          break;
      }
    } catch (e) {
      return AuthenticationStatus.unknown;
    }
    return AuthenticationStatus.unknown;
  }

  userSignupRequest({
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
    } on FirebaseAuthException catch (e) {
      String message = e.code;
    } catch (e) {
      print(e);
    }
  }
}
