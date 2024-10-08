import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_hide/scroll_to_hide.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:shop_mobile/features/products/presentation/bloc/categories/categories_bloc.dart';
import 'package:shop_mobile/features/products/presentation/bloc/categories/categories_event.dart';
import 'package:shop_mobile/features/products/presentation/bloc/categories/categories_state.dart';
import 'package:shop_mobile/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:shop_mobile/features/products/presentation/bloc/products/products_event.dart';
import 'package:shop_mobile/features/products/presentation/bloc/products/products_state.dart';
import 'package:shop_mobile/features/products/presentation/widgets/app_bar_cart.dart';
import 'package:shop_mobile/features/products/presentation/widgets/main_drawer.dart';
import 'package:shop_mobile/features/products/presentation/widgets/product_item.dart';
import 'package:shop_mobile/features/products/presentation/widgets/search_input_dialog.dart';

class ProductsScreen extends StatefulWidget {
  static const String routeName = '/';
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final controller = ScrollController();
  int? categoryId;
  String? search;

  @override
  void initState() {
    BlocProvider.of<CategoriesBloc>(context).add(const GetCategories());
    final productsBloc = BlocProvider.of<ProductsBloc>(context);
    BlocProvider.of<CartBloc>(context).add(const GetCart());
    productsBloc.add(const GetProducts(page: 1));

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        final productsData = productsBloc.state.productsDataEntity;
        if (productsData != null &&
            productsData.currentPage < productsData.totalPages) {
          productsBloc.add(GetProducts(
            page: productsData.currentPage + 1,
            categoryId: categoryId,
            search: search,
          ));
        }
      }
    });
    super.initState();
  }

  Future refresh() async {
    BlocProvider.of<ProductsBloc>(context).add(ProductsRefresh(
      categoryId: categoryId,
      search: search,
    ));
  }

  void searchProducts(String? word) {
    setState(() {
      search = word;
    });
    refresh();
  }

  void showSearchInputDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return SearchInputDialog(
          searchProducts: searchProducts,
          searchText: search,
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Products'),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    showSearchInputDialog();
                  },
                  icon: Icon(
                    search != null ? Icons.search_off : Icons.search,
                    size: 28,
                  ),
                ),
                const AppBarCart(),
              ],
            ),
          ],
        ),
      ),
      drawer: const MainDrawer(),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Column(
            children: [
              ScrollToHide(
                scrollController: controller,
                hideDirection: Axis.vertical,
                height: 60,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  height: 60,
                  child: BlocBuilder<CategoriesBloc, CategoriesState>(
                    builder: (context, state) {
                      if (state is CategoriesLoaded) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.categories.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Container(
                                margin: const EdgeInsets.only(right: 6),
                                child: OutlinedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: categoryId == null
                                        ? Colors.red
                                        : Colors.transparent,
                                    foregroundColor: categoryId == null
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      categoryId = null;
                                    });
                                    refresh();
                                  },
                                  child: const Text('All'),
                                ),
                              );
                            }
                            final category = state.categories[index - 1];
                            return Container(
                              margin: const EdgeInsets.only(right: 6),
                              child: OutlinedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: categoryId == category.id
                                      ? Colors.red
                                      : Colors.transparent,
                                  foregroundColor: categoryId == category.id
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    categoryId = category.id;
                                  });
                                  refresh();
                                },
                                child: Text(category.name),
                              ),
                            );
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ),
              Expanded(
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

                      return Container(
                        color: Colors.white,
                        child: GridView.builder(
                          controller: controller,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 4.6,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: productsData.products.length,
                          itemBuilder: (context, index) {
                            if (index <= productsData.products.length) {
                              return ProductItem(
                                  product: productsData.products[index]);
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}

class MyClass extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
