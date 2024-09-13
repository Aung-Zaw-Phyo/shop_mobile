import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_mobile/core/helper.dart';
import 'package:shop_mobile/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:shop_mobile/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:shop_mobile/features/auth/presentation/pages/login_screen.dart';
import 'package:shop_mobile/features/orders/presentation/pages/orders_screen.dart';
import 'package:shop_mobile/features/products/presentation/pages/products_screen.dart';
import 'package:shop_mobile/features/profile/presentation/pages/profile_screen.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool isToken = false;

  void checkToken() async {
    final result = await hasToken();
    setState(() {
      isToken = result;
    });
  }

  @override
  void initState() {
    checkToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.shopify,
                  size: 68,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  'MY SHOP',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                )
              ],
            ),
          ),
          if (isToken)
            ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Profile',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 22,
                    ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, ProfileScreen.routeName);
              },
            ),
          if (isToken)
            ListTile(
              leading: Icon(
                Icons.shopping_bag_rounded,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Orders',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 22,
                    ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, OrdersScreen.routeName);
              },
            ),
          if (isToken)
            ListTile(
              leading: Icon(
                Icons.logout,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Logout',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 22,
                    ),
              ),
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(const AuthLogout());
                Navigator.pushReplacementNamed(
                    context, ProductsScreen.routeName);
              },
            ),
          if (!isToken)
            ListTile(
              leading: Icon(
                Icons.login,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Login',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 22,
                    ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, LoginScreen.routeName);
              },
            ),
        ],
      ),
    );
  }
}
