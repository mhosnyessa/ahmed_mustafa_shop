import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:dartz/dartz.dart';

import 'products_repository.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  NetworkService() : db = FirebaseFirestore.instance;
  final FirebaseFirestore db;

  Future<Either<String, List>> fetchAllProducts() async {
    List productsList = [];
    try {
      QuerySnapshot querySnapshot = await db.collection("products").get();
      querySnapshot.docs.forEach((element) {
        productsList.add(element.data());
      });
      return Right(productsList);
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }
}
