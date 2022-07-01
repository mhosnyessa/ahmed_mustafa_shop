part of 'products_bloc.dart';

class ProductsState extends Equatable {
  const ProductsState._({
    this.productsList = const [],
    this.status = ProductsStatus.loading,
  });

  const ProductsState.loading() : this._();

  const ProductsState.noResults() : this._();

  const ProductsState.noInternet() : this._();

  const ProductsState.resultsReady(List productsList)
      : this._(productsList: productsList, status: ProductsStatus.resultsReady);

  final List productsList;
  final ProductsStatus status;

  @override
  List<Object> get props => [productsList];
}
