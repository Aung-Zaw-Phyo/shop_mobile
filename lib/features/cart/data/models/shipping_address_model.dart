import 'package:shop_mobile/features/cart/domain/entities/shipping_address.dart';

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

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'country': country,
        'city': city,
        'line1': line1,
        'line2': line2,
        'state': state,
        'postal_code': postalCode,
      };
}
