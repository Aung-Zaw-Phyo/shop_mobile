import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final void Function() onAddItem;
  const AddButton({super.key, required this.onAddItem});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onAddItem,
      icon: const Icon(Icons.add),
      style: IconButton.styleFrom(
        backgroundColor: Colors.black12,
      ),
    );
  }
}
