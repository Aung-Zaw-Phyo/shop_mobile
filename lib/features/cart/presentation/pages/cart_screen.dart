import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:shop_mobile/features/cart/presentation/widgets/item.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart';
  const CartScreen({super.key});

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

  Future refresh() async {
    BlocProvider.of<CartBloc>(context).add(const GetCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        title: const Text('Cart'),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Padding(
          padding: const EdgeInsets.all(6),
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
                return ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    return Item(item: cart.items[index]);
                  },
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
