import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class GetProducts extends ProductsEvent {
  final int page;
  const GetProducts(this.page);

  @override
  List<Object> get props => [page];
}

class ProductsRefresh extends ProductsEvent {
  const ProductsRefresh();
}
