import 'package:flutter/material.dart';
import 'package:shop_mobile/features/products/domain/entities/product.dart';
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

      default:
        return _materialRoute(const ProductsScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
