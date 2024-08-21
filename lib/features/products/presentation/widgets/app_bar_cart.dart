import 'package:flutter/material.dart';
import 'package:shop_mobile/features/cart/presentation/pages/cart_screen.dart';

class AppBarCart extends StatelessWidget {
  const AppBarCart({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(CartScreen.routeName);
      },
      child: const Icon(
        Icons.shopping_cart,
        size: 28,
      ),
    );
  }
}
