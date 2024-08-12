import 'package:shop_mobile/features/products/domain/entities/variant.dart';

class VariantModel extends VariantEntity {
  const VariantModel({
    required int id,
    required String color,
    required String size,
    required int stock,
  }) : super(id: id, color: color, size: size, stock: stock);

  factory VariantModel.fromJson(Map<String, dynamic> json) => VariantModel(
        id: json['id'],
        color: json['color'],
        size: json['size'],
        stock: json['stock'],
      );
}
