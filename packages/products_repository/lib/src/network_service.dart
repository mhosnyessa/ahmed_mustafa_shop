import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'products_repository.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  NetworkService() : db = FirebaseFirestore.instance;
  final FirebaseFirestore db;

  Future<void> fetchAllProducts() async {
    await db.collection("products").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
    // DatabaseReference ref =
    //     FirebaseDatabase.instance.ref("products/products_all");

    // print('right before fetching data');

    // dynamic data = await ref.get().then((data) {
    //   print('#data from firebase : ' + data.toString());
    // }).onError((error, stackTrace) {
    //   print('error from get() firebase : ' + error.toString());
    // });

// await ref.set({
//   "name": "John",
//   "age": 18,
//   "address": {
//     "line1": "100 Mountain View"
//   }
// });
  }
}
