import 'package:flutter/material.dart';
import 'package:shop_mobile/core/helper.dart';
import 'package:shop_mobile/features/products/domain/entities/product.dart';

class AddToCart extends StatefulWidget {
  final ProductEntity product;
  const AddToCart({super.key, required this.product});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  var _selectedVariant;
  void _submit() {
    if (_selectedVariant == null) {
      error(context, 'Please select variant');
      return;
    }

    print(_selectedVariant.id);
  }

  @override
  Widget build(BuildContext context) {
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
  }
}
