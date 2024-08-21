import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_mobile/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:shop_mobile/features/products/presentation/bloc/products/products_event.dart';
import 'package:shop_mobile/features/products/presentation/bloc/products/products_state.dart';
import 'package:shop_mobile/features/products/presentation/widgets/app_bar_cart.dart';
import 'package:shop_mobile/features/products/presentation/widgets/product_item.dart';

class ProductsScreen extends StatefulWidget {
  static const String routeName = '/';
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    final productsBloc = BlocProvider.of<ProductsBloc>(context);
    productsBloc.add(const GetProducts(1));

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        final productsData = productsBloc.state.productsDataEntity;
        if (productsData != null &&
            productsData.currentPage < productsData.totalPages) {
          productsBloc.add(GetProducts(productsData.currentPage + 1));
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future refresh() async {
    BlocProvider.of<ProductsBloc>(context).add(const ProductsRefresh());
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
            AppBarCart(),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Padding(
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
                final productsData = state.productsDataEntity!;

                return GridView.builder(
                  controller: controller,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 4.6,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: productsData.products.length,
                  itemBuilder: (context, index) {
                    if (index <= productsData.products.length) {
                      return ProductItem(product: productsData.products[index]);
                    } else {
                      return const SizedBox();
                    }
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
