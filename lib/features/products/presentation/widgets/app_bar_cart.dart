import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_mobile/core/helper.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:shop_mobile/features/cart/presentation/pages/cart_screen.dart';
import 'package:badges/badges.dart' as badges;

class AppBarCart extends StatefulWidget {
  const AppBarCart({super.key});

  @override
  State<AppBarCart> createState() => _AppBarCartState();
}

class _AppBarCartState extends State<AppBarCart> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final isToken = await hasToken();
        if (!isToken) {
          // ignore: use_build_context_synchronously
          error(context, 'Please login or register.');
          return;
        }
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamed(CartScreen.routeName);
      },
      icon: badges.Badge(
        position: badges.BadgePosition.topEnd(top: -14, end: -10),
        badgeContent: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            final cart = state.cartEntity;
            final count = cart != null ? cart.items.length : 0;
            return Text(count.toString(),
                style: const TextStyle(color: Colors.white));
          },
        ),
        badgeStyle: const badges.BadgeStyle(badgeColor: Colors.black),
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
