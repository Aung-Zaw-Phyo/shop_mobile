import 'package:shop_mobile/features/orders/domain/entities/image.dart';

class ImageModel extends ImageEntity {
  const ImageModel({required int id, required String name})
      : super(id: id, name: name);

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      ImageModel(id: json['id'], name: json['name']);
}
