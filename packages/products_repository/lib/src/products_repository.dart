import 'dart:async';

import 'dart:io';

import './network_service.dart';
import './shared_pref_service.dart';

enum ProductsStatus {
  stable,
  loading,
  noInternet,
  noResults,
}

class ProductsRepository {
  final _controller = StreamController<ProductsStatus>();
  final NetworkService _networkService = NetworkService();
  final prefs = SharedPreferencesService();

  void dispose() => _controller.close();
}
