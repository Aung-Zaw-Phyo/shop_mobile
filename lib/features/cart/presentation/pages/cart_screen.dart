import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_mobile/core/helper.dart';
import 'package:shop_mobile/features/cart/domain/entities/item.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:shop_mobile/features/cart/presentation/widgets/item.dart';
import 'package:shop_mobile/features/cart/presentation/widgets/shipping_form_dialog.dart';
import 'package:shop_mobile/features/products/presentation/widgets/app_bar_cart.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart';
  const CartScreen({super.key});

  void test() {}

  @override
  State<StatefulWidget> createState() {
    return _CartScreenState();
  }
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    BlocProvider.of<CartBloc>(context).add(const GetCart());
    super.initState();
  }

  void _showShippingAddressForm(List<ItemEntity> items) {
    if (items.isEmpty) {
      error(context, 'Your cart is empty, go shopping!');
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const ShippingFormDialog();
      },
    );
  }

  Future refresh() async {
    BlocProvider.of<CartBloc>(context).add(const GetCart());
  }

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
            Text('Orders'),
            AppBarCart(isCartScreen: true),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartFailed) {
              return Center(
                child: Text(state.errors![0]),
              );
            }

            if (state is CartLoaded) {
              final cart = state.cartEntity!;
              if (cart.items.isEmpty) {
                return const Center(
                  child: Text(
                    'Your cart is empty,  go shopping.',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      color: const Color.fromARGB(55, 158, 158, 158),
                      child: ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          return Item(item: cart.items[index]);
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    color: Colors.white,
                    child: OutlinedButton(
                      onPressed: () async {
                        _showShippingAddressForm(cart.items);
                      },
                      style: OutlinedButton.styleFrom(),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
