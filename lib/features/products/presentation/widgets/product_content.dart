import 'package:flutter/material.dart';
import 'package:shop_mobile/features/products/domain/entities/product.dart';

class ProductContent extends StatelessWidget {
  final ProductEntity product;
  const ProductContent({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Flexible(
                child: Text(
                  product.name,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            Text(
              '\$${product.price}',
              style: const TextStyle(
                fontSize: 22,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
