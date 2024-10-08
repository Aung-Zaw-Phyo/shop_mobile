import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class GetProducts extends ProductsEvent {
  final int page;
  final int? categoryId;
  final String? search;
  const GetProducts({required this.page, this.categoryId, this.search});

  @override
  List<Object?> get props => [page, categoryId, search];
}

class ProductsRefresh extends ProductsEvent {
  final int? categoryId;
  final String? search;
  const ProductsRefresh({this.categoryId, this.search});

  @override
  List<Object?> get props => [categoryId, search];
}
