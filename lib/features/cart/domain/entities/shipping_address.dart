import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/cart/data/models/shipping_address_model.dart';

class ShippingAddressEntity extends Equatable {
  final String name;
  final String phone;
  final String country;
  final String city;
  final String line1;
  final String line2;
  final String state;
  final String postalCode;

  const ShippingAddressEntity({
    required this.name,
    required this.phone,
    required this.country,
    required this.city,
    required this.line1,
    required this.line2,
    required this.state,
    required this.postalCode,
  });

  ShippingAddressModel toModel() => ShippingAddressModel(
        name: name,
        phone: phone,
        country: country,
        city: city,
        line1: line1,
        line2: line2,
        state: state,
        postalCode: postalCode,
      );

  @override
  List<Object?> get props => [
        name,
        phone,
        country,
        city,
        line1,
        line2,
        state,
        postalCode,
      ];
}
