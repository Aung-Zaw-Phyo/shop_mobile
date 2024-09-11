import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_mobile/config/routes.dart';
import 'package:shop_mobile/core/constants/constants.dart';
import 'package:shop_mobile/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/item/item_bloc.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/payment/payment_bloc.dart';
import 'package:shop_mobile/features/orders/presentation/bloc/order_details/order_details_bloc.dart';
import 'package:shop_mobile/features/orders/presentation/bloc/orders/orders_bloc.dart';
import 'package:shop_mobile/features/products/presentation/bloc/product_detail/product_detail_bloc.dart';
import 'package:shop_mobile/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:shop_mobile/features/products/presentation/pages/products_screen.dart';
import 'package:shop_mobile/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = Constant.stripePublishableKey;
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsBloc>(create: (_) => locator<ProductsBloc>()),
        BlocProvider<OrdersBloc>(create: (_) => locator<OrdersBloc>()),
        BlocProvider<OrderDetailsBloc>(
            create: (_) => locator<OrderDetailsBloc>()),
        BlocProvider<CartBloc>(create: (_) => locator<CartBloc>()),
        BlocProvider<ItemBloc>(create: (_) => locator<ItemBloc>()),
        BlocProvider<PaymentBloc>(create: (_) => locator<PaymentBloc>()),
        BlocProvider<AuthBloc>(create: (_) => locator<AuthBloc>()),
        BlocProvider<ProductDetailBloc>(
            create: (_) => locator<ProductDetailBloc>()),
      ],
      child: MaterialApp(
        title: 'My Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.latoTextTheme().copyWith(
            titleLarge: GoogleFonts.lato(),
            titleMedium: GoogleFonts.lato(),
            titleSmall: GoogleFonts.lato(),
          ),
        ),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const ProductsScreen(),
      ),
    );
  }
}
