import 'package:flutter/material.dart';
import 'package:shop_mobile/core/helper.dart';
import 'package:shop_mobile/features/cart/presentation/pages/cart_screen.dart';

class AppBarCart extends StatelessWidget {
  const AppBarCart({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final isToken = await hasToken();
        if (!isToken) {
          // ignore: use_build_context_synchronously
          error(context, 'Please login or register.');
          return;
        }
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamed(CartScreen.routeName);
      },
      child: const Icon(
        Icons.shopping_cart,
        size: 28,
      ),
    );
  }
}
