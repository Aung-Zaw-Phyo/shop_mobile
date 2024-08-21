import 'package:shop_mobile/features/cart/data/models/image_model.dart';
import 'package:shop_mobile/features/cart/domain/entities/product.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required int id,
    required String name,
    required String description,
    required int price,
    required List<ImageModel> images,
  }) : super(
          id: id,
          name: name,
          price: price,
          description: description,
          images: images,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        images: json['images']
            .map<ImageModel>(
              (dynamic i) => ImageModel.fromJson(i as Map<String, dynamic>),
            )
            .toList(),
      );
}
