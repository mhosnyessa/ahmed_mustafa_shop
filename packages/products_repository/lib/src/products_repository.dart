import 'dart:async';

import 'dart:io';
import 'dart:ui';

import 'package:dartz/dartz.dart';

import './network_service.dart';
import './shared_pref_service.dart';

enum ProductsStatus { stable, loading, noInternet, noResults, error }

class ProductsRepository {
  final _controller = StreamController<ProductsStatus>();
  final NetworkService _networkService = NetworkService();
  final SharedPreferencesService _prefs = SharedPreferencesService();

  Stream<ProductsStatus> get status async* {
    yield ProductsStatus.loading;
    yield* _controller.stream;
  }

  Future<Either<String, List>> getProducts() async {
    _controller.add(ProductsStatus.loading);
    Either<String, List> returnedObjOrError =
        await _networkService.fetchAllProducts();
    return returnedObjOrError;
  }

  void dispose() => _controller.close();
}
