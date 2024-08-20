import 'package:equatable/equatable.dart';

class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class GetProductDetail extends ProductDetailEvent {
  final int productId;
  const GetProductDetail(this.productId);

  @override
  List<Object> get props => [productId];
}
