import 'package:shop_mobile/features/cart/data/models/variant_model.dart';
import 'package:shop_mobile/features/cart/domain/entities/item.dart';

class ItemModel extends ItemEntity {
  const ItemModel({
    required int id,
    required int quantity,
    required int amount,
    required VariantModel variant,
  }) : super(
          id: id,
          quantity: quantity,
          amount: amount,
          variant: variant,
        );

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        id: json['id'],
        quantity: json['quantity'],
        amount: json['amount'],
        variant: VariantModel.fromJson(json['variant'] as Map<String, dynamic>),
      );
}
