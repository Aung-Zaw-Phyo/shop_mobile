import 'package:flutter/material.dart';
import 'package:shop_mobile/features/orders/domain/entities/shipping_address.dart';
import 'package:shop_mobile/features/orders/presentation/widgets/shipping_info_item.dart';

class ShippingAddress extends StatelessWidget {
  final ShippingAddressEntity shippingAddress;
  const ShippingAddress({super.key, required this.shippingAddress});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      child: Column(
        children: [
          ShippingInfoItem(label: 'Name', value: shippingAddress.name),
          const SizedBox(height: 4),
          ShippingInfoItem(label: 'Phone', value: shippingAddress.phone),
          const SizedBox(height: 4),
          ShippingInfoItem(label: 'Country', value: shippingAddress.country),
          const SizedBox(height: 4),
          ShippingInfoItem(label: 'City', value: shippingAddress.city),
          const SizedBox(height: 4),
          ShippingInfoItem(label: 'Address', value: shippingAddress.line1),
          const SizedBox(height: 4),
          ShippingInfoItem(label: 'Address', value: shippingAddress.line2),
          const SizedBox(height: 4),
          ShippingInfoItem(label: 'State', value: shippingAddress.state),
          const SizedBox(height: 4),
          ShippingInfoItem(
              label: 'Postal Code', value: shippingAddress.postalCode),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
