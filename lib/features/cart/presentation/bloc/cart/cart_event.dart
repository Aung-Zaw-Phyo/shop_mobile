import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/cart/domain/entities/cart.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCart extends CartEvent {
  const GetCart();
}

class CartItemChange extends CartEvent {
  final CartEntity cartEntity;
  const CartItemChange(this.cartEntity);

  @override
  List<Object> get props => [cartEntity];
}
