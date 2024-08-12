import 'package:shop_mobile/features/products/data/models/category_model.dart';
import 'package:shop_mobile/features/products/data/models/image_model.dart';
import 'package:shop_mobile/features/products/data/models/variant_model.dart';
import 'package:shop_mobile/features/products/domain/entities/product.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required int id,
    required String name,
    required String description,
    required int price,
    required List<CategoryModel> categories,
    required List<VariantModel> variants,
    required List<ImageModel> images,
  }) : super(
          id: id,
          name: name,
          price: price,
          description: description,
          categories: categories,
          variants: variants,
          images: images,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        categories: json['categories']
            .map<CategoryModel>(
              (dynamic i) => CategoryModel.fromJson(i as Map<String, dynamic>),
            )
            .toList(),
        variants: json['variants']
            .map<VariantModel>(
              (dynamic i) => VariantModel.fromJson(i as Map<String, dynamic>),
            )
            .toList(),
        images: json['images']
            .map<ImageModel>(
              (dynamic i) => ImageModel.fromJson(i as Map<String, dynamic>),
            )
            .toList(),
      );
}
