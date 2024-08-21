import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/cart/domain/entities/item.dart';

class CartEntity extends Equatable {
  final int id;
  final List<ItemEntity> items;
  const CartEntity({required this.id, required this.items});

  @override
  List<Object> get props => [id, items];
}
