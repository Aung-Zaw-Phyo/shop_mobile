import 'package:flutter/material.dart';
import 'package:shop_mobile/features/auth/presentation/pages/login_screen.dart';
import 'package:shop_mobile/features/auth/presentation/pages/register_screen.dart';
import 'package:shop_mobile/features/products/domain/entities/product.dart';
import 'package:shop_mobile/features/cart/presentation/pages/cart_screen.dart';
import 'package:shop_mobile/features/products/presentation/pages/product_detail_screen.dart';
import 'package:shop_mobile/features/products/presentation/pages/products_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case ProductsScreen.routeName:
        return _materialRoute(const ProductsScreen());

      case ProductDetailScreen.routeName:
        return _materialRoute(
          ProductDetailScreen(
            product: settings.arguments as ProductEntity,
          ),
        );

      case CartScreen.routeName:
        return _materialRoute(const CartScreen());

      case LoginScreen.routeName:
        return _materialRoute(const LoginScreen());

      case RegisterScreen.routeName:
        return _materialRoute(const RegisterScreen());

      default:
        return _materialRoute(const ProductsScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
