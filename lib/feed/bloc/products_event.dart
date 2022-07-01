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
  @override
  List<Object> get props => [];
}
