import 'package:flutter/material.dart';
import 'package:shop_mobile/features/products/domain/entities/product.dart';
import 'package:shop_mobile/features/products/presentation/widgets/add_to_cart.dart';
import 'package:shop_mobile/features/products/presentation/widgets/product_content.dart';
import 'package:shop_mobile/features/products/presentation/widgets/product_images.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/productDetail';
  final ProductEntity product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Details'),
            Icon(
              Icons.shopping_cart,
              size: 28,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ProductImages(product: product),
            ProductContent(product: product),
            AddToCart(product: product),
          ],
        ),
      ),
    );
  }
}
