import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_mobile/core/helper.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/item/item_bloc.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/item/item_event.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/item/item_state.dart';
import 'package:shop_mobile/features/products/domain/entities/product.dart';

class AddToCart extends StatefulWidget {
  final ProductEntity product;
  const AddToCart({super.key, required this.product});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  var _selectedVariant;
  var isSubmit = false;
  void _submit() {
    if (_selectedVariant == null) {
      error(context, 'Please select variant');
      return;
    }
    BlocProvider.of<ItemBloc>(context).add(
      AddItem(
        variantId: _selectedVariant.id,
      ),
    );
    isSubmit = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemBloc, ItemState>(
      builder: (context, state) {
        if (state is ItemFailed && isSubmit == true) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            error(context, state.errors[0]);
            isSubmit = false;
          });
        }

        if (state is ItemLoaded && isSubmit == true) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            success(context, 'Item added.');
            BlocProvider.of<CartBloc>(context)
                .add(CartItemChange(state.cartEntity));
            isSubmit = false;
          });
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: DropdownButtonFormField(
                value: _selectedVariant,
                onChanged: (value) {
                  setState(() {
                    _selectedVariant = value!;
                  });
                },
                items: [
                  for (final variant in widget.product.variants)
                    DropdownMenuItem(
                      value: variant,
                      child: Text(
                        'color - ${variant.color} , size - ${variant.size}',
                      ),
                    )
                ],
                decoration: const InputDecoration(
                  labelText: 'Please select variant',
                ),
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.add_shopping_cart_outlined),
              label: const Text('Add To Cart'),
              style: ElevatedButton.styleFrom(
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
