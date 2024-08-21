import 'package:shop_mobile/features/cart/data/models/product_model.dart';
import 'package:shop_mobile/features/cart/domain/entities/variant.dart';

class VariantModel extends VariantEntity {
  const VariantModel({
    required int id,
    required String color,
    required String size,
    required int stock,
    required ProductModel product,
  }) : super(
          id: id,
          color: color,
          size: size,
          stock: stock,
          product: product,
        );

  factory VariantModel.fromJson(Map<String, dynamic> json) => VariantModel(
        id: json['id'],
        color: json['color'],
        size: json['size'],
        stock: json['stock'],
        product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      );
}
