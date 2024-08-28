import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  final String imageLink;
  const ItemImage({super.key, required this.imageLink});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: Colors.black26,
        ),
      ),
      child: Image.network(
        imageLink,
        width: 40,
        fit: BoxFit.cover,
      ),
    );
  }
}
