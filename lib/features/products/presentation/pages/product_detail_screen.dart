import 'package:flutter/material.dart';
import 'package:shop_mobile/features/products/domain/entities/product.dart';
import 'package:shop_mobile/features/products/presentation/widgets/add_to_cart.dart';
import 'package:shop_mobile/features/products/presentation/widgets/app_bar_cart.dart';
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
            AppBarCart(),
          ],
        ),
      ),
      body: Column(
        children: [
          ProductImages(product: product),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                border: Border(
                    top: BorderSide(color: Colors.black.withOpacity(0.3))),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProductContent(product: product),
                    const SizedBox(height: 10),
                    AddToCart(product: product),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
