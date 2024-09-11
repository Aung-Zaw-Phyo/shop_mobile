import 'package:flutter/material.dart';
import 'package:shop_mobile/features/cart/domain/entities/item.dart';
import 'package:shop_mobile/features/cart/presentation/widgets/info.dart';
import 'package:shop_mobile/features/cart/presentation/widgets/item_action.dart';
import 'package:shop_mobile/features/cart/presentation/widgets/item_image.dart';

class Item extends StatefulWidget {
  final ItemEntity item;
  const Item({super.key, required this.item});

  @override
  State<StatefulWidget> createState() {
    return _ItemState();
  }
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          ItemImage(imageLink: widget.item.variant.product.images[0].name),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Info(item: widget.item),
                  Column(
                    children: [
                      Text(
                        '\$${widget.item.amount}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ItemAction(variantId: widget.item.variant.id),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
