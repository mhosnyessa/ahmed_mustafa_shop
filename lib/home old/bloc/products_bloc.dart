import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_repository/src/products_repository.dart';

import '../../shared/data/product.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository,
        super(const ProductsState.loading()) {
    on<ProductsAllRequested>(_onProductsAllRequested);
  }
  final ProductsRepository _productsRepository;

  Future<FutureOr<void>> _onProductsAllRequested(
      ProductsAllRequested event, Emitter<ProductsState> emit) async {
    await _productsRepository.getProducts();
  }
}
