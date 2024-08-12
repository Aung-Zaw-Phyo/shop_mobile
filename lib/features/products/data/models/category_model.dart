import 'package:shop_mobile/features/products/domain/entities/category.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({required int id, required String name})
      : super(id: id, name: name);

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(id: json['id'], name: json['name']);
}
