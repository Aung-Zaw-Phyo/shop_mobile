import 'package:flutter/material.dart';
import 'package:shop_mobile/features/cart/domain/entities/item.dart';

class Info extends StatelessWidget {
  final ItemEntity item;
  const Info({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              item.variant.product.name,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '\$${item.variant.product.price.toString()}',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 4),
            const Text('x'),
            const SizedBox(width: 4),
            Text(item.quantity.toString()),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'Color - ',
              style: TextStyle(),
            ),
            Text(
              item.variant.color,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Size - ',
              style: TextStyle(),
            ),
            Text(
              item.variant.size,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
