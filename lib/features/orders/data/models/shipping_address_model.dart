import 'package:shop_mobile/features/orders/domain/entities/shipping_address.dart';

class ShippingAddressModel extends ShippingAddressEntity {
  const ShippingAddressModel({
    required String name,
    required String phone,
    required String country,
    required String city,
    required String line1,
    required String line2,
    required String state,
    required String postalCode,
  }) : super(
          name: name,
          phone: phone,
          country: country,
          city: city,
          line1: line1,
          line2: line2,
          state: state,
          postalCode: postalCode,
        );

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) =>
      ShippingAddressModel(
        name: json['name'],
        phone: json['phone'],
        country: json['country'],
        city: json['city'],
        line1: json['line1'],
        line2: json['line2'],
        state: json['state'],
        postalCode: json['postal_code'],
      );
}
