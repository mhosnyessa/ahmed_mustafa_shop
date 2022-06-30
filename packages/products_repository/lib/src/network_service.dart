import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'products_repository.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  Map<String, dynamic> returnedObj = {
    'auth_status': ProductsStatus.noInternet,
    'response': {
      'name': null,
      'email': null,
      'username': null,
      'password': null,
    }
  };
  Future<ProductsStatus> userLoginRequest(String email, String password) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      return ProductsStatus.noResults;
    }).onError((error, stackTrace) {
      return ProductsStatus.loading;
    });
    return ProductsStatus.loading;
  }

  Future<ProductsStatus> userSignupRequest({
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
      return ProductsStatus.noResults;
    } on FirebaseAuthException catch (e) {
      var message = e;
      print('\n\n\n\n\n firebase exception : ' +
          message.toString() +
          '\n\n\n\n\n');
    } catch (e) {
      print('firebase catch e : ' + e.toString());
    }
    return ProductsStatus.loading;
  }

  Future<void> getAllProducts() async {}
}
