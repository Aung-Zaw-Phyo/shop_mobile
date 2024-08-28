import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_mobile/core/helper.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/item/item_bloc.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/item/item_event.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/item/item_state.dart';
import 'package:shop_mobile/features/cart/presentation/widgets/add_button.dart';
import 'package:shop_mobile/features/cart/presentation/widgets/remove_button.dart';

class ItemAction extends StatefulWidget {
  final int variantId;
  const ItemAction({super.key, required this.variantId});

  @override
  State<ItemAction> createState() => _ItemActionState();
}

class _ItemActionState extends State<ItemAction> {
  var isSubmit = false;

  void addItem() {
    BlocProvider.of<ItemBloc>(context).add(
      AddItem(
        variantId: widget.variantId,
      ),
    );
    isSubmit = true;
  }

  void removeItem() {
    BlocProvider.of<ItemBloc>(context).add(
      RemoveItem(
        variantId: widget.variantId,
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
          BlocProvider.of<CartBloc>(context)
              .add(CartItemChange(state.cartEntity));
          isSubmit = false;
        }

        return Row(
          children: [
            RemoveButton(onRemoveItem: removeItem),
            AddButton(onAddItem: addItem),
          ],
        );
      },
    );
  }
}
