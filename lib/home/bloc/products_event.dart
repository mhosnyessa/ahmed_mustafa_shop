part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class ProductsAllRequested extends ProductsEvent {
  @override
  List<Object> get props => [];
}

class ProductsStateChanged extends ProductsEvent {
  final List productsList;

  const ProductsStateChanged(this.productsList);
  @override
  List<Object> get props => [productsList];
}
