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
    add(ProductsAllRequested());
  }
  final ProductsRepository _productsRepository;
  List? productsList;

  Future<void> _onProductsAllRequested(
      ProductsAllRequested event, Emitter<ProductsState> emit) async {
    print('just before getting products');
    await _productsRepository.getProducts().then((valueOrError) {
      valueOrError.fold((l) => null, (r) {
        productsList = r;
        emit(ProductsState.resultsReady(r));
      });
    }).onError((error, stackTrace) {
      emit(ProductsState.noResults());
    });
  }
}
