import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_mobile/features/products/domain/entities/product.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductImages extends StatefulWidget {
  final ProductEntity product;
  const ProductImages({super.key, required this.product});

  @override
  State<StatefulWidget> createState() {
    return _ProductImagesState();
  }
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImageIndex = 0;

  void onSelectImageIndex(int index) {
    setState(() {
      selectedImageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Hero(
                tag: widget.product.id,
                child: Image.network(
                  widget.product.images[selectedImageIndex].name,
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: widget.product.images
                    .asMap()
                    .map(
                      (index, image) {
                        return MapEntry(
                            index,
                            InkWell(
                              borderRadius: BorderRadius.circular(8),
                              highlightColor: Colors.white,
                              splashColor: Colors.white,
                              onTap: () {
                                onSelectImageIndex(index);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(2),
                                padding: const EdgeInsets.all(5),
                                width: 60,
                                height: 75,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    width: 2,
                                    color: selectedImageIndex == index
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                ),
                                child: FadeInImage(
                                  placeholder: MemoryImage(kTransparentImage),
                                  image: NetworkImage(image.name),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ));
                      },
                    )
                    .values
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
