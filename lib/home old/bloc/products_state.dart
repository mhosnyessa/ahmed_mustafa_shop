part of 'products_bloc.dart';

class ProductsState extends Equatable {
  const ProductsState._({
    this.productsList = const [],
  });

  const ProductsState.loading() : this._();

  const ProductsState.noResults() : this._();

  const ProductsState.noInternet() : this._();

  const ProductsState.resultsReady(List<Product> productsList)
      : this._(productsList: productsList);

  final List<Product> productsList;

  @override
  List<Object> get props => [productsList];
}
