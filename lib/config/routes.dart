import 'package:flutter/material.dart';
import 'package:shop_mobile/features/auth/presentation/pages/login_screen.dart';
import 'package:shop_mobile/features/auth/presentation/pages/register_screen.dart';
import 'package:shop_mobile/features/cart/presentation/pages/check_payment_screen.dart';
import 'package:shop_mobile/features/orders/presentation/pages/order_details_screen.dart';
import 'package:shop_mobile/features/orders/presentation/pages/orders_screen.dart';
import 'package:shop_mobile/features/products/domain/entities/product.dart';
import 'package:shop_mobile/features/cart/presentation/pages/cart_screen.dart';
import 'package:shop_mobile/features/products/presentation/pages/product_detail_screen.dart';
import 'package:shop_mobile/features/products/presentation/pages/products_screen.dart';
import 'package:shop_mobile/features/profile/presentation/pages/profile_screen.dart';

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

      case CheckPaymentScreen.routeName:
        return _materialRoute(
          CheckPaymentScreen(
            sessionId: settings.arguments as String,
          ),
        );

      case OrdersScreen.routeName:
        return _materialRoute(const OrdersScreen());

      case OrderDetailsScreen.routeName:
        return _materialRoute(
          OrderDetailsScreen(
            orderId: settings.arguments as int,
          ),
        );

      case ProfileScreen.routeName:
        return _materialRoute(const ProfileScreen());

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
