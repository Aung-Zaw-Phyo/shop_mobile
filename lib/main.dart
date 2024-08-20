import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_mobile/config/routes.dart';
import 'package:shop_mobile/features/products/presentation/bloc/product_detail/product_detail_bloc.dart';
import 'package:shop_mobile/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:shop_mobile/features/products/presentation/pages/products_screen.dart';
import 'package:shop_mobile/injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
