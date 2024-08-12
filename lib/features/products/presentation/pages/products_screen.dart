import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_mobile/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:shop_mobile/features/products/presentation/bloc/products/products_event.dart';
import 'package:shop_mobile/features/products/presentation/bloc/products/products_state.dart';
import 'package:shop_mobile/features/products/presentation/widgets/product_item.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    final productsBloc = BlocProvider.of<ProductsBloc>(context);
    productsBloc.add(const GetProducts(page: 1));

    super.initState();
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
            Text('Shopping'),
            Icon(
              Icons.shopping_cart,
              size: 28,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProductsFailed) {
              return Center(
                child: Text(state.errors![0]),
              );
            }
            if (state is ProductsLoaded) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 4.6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: state.products!.length,
                itemBuilder: (context, index) {
                  return ProductItem(product: state.products![index]);
                },
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
