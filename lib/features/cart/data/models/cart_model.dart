import 'package:shop_mobile/features/cart/data/models/item_model.dart';
import 'package:shop_mobile/features/cart/domain/entities/cart.dart';

class CartModel extends CartEntity {
  const CartModel({
    required int id,
    required List<ItemModel> items,
  }) : super(
          id: id,
          items: items,
        );

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json['id'],
        items: json['items']
            .map<ItemModel>(
              (dynamic i) => ItemModel.fromJson(i as Map<String, dynamic>),
            )
            .toList(),
      );
}
