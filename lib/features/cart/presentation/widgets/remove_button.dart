import 'package:flutter/material.dart';

class RemoveButton extends StatelessWidget {
  final void Function() onRemoveItem;
  const RemoveButton({super.key, required this.onRemoveItem});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onRemoveItem,
      icon: const Icon(Icons.remove),
      style: IconButton.styleFrom(
        backgroundColor: Colors.black12,
      ),
    );
  }
}
