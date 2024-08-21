import 'package:shop_mobile/features/cart/data/models/variant_model.dart';
import 'package:shop_mobile/features/cart/domain/entities/item.dart';

class ItemModel extends ItemEntity {
  const ItemModel({
    required int id,
    required int quantity,
    required VariantModel variant,
  }) : super(
          id: id,
          quantity: quantity,
          variant: variant,
        );

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        id: json['id'],
        quantity: json['quantity'],
        variant: VariantModel.fromJson(json['variant'] as Map<String, dynamic>),
      );
}
