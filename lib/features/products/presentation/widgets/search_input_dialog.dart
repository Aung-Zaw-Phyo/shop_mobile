import 'package:flutter/material.dart';

class SearchInputDialog extends StatefulWidget {
  final void Function(String? word) searchProducts;
  final String? searchText;
  const SearchInputDialog({
    super.key,
    required this.searchProducts,
    required this.searchText,
  });

  @override
  State<SearchInputDialog> createState() {
    return _SearchInputDialogState();
  }
}

class _SearchInputDialogState extends State<SearchInputDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.searchText ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        suffixIcon: _controller.text.isNotEmpty
                            ? IconButton(
                                icon:
                                    const Icon(Icons.clear, color: Colors.grey),
                                onPressed: () {
                                  _controller.clear();
                                  widget.searchProducts(null);
                                },
                              )
                            : null,
                      ),
                      onChanged: (text) {
                        setState(() {}); // Refresh to show/hide the clear icon
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.searchProducts(_controller.text);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                    ),
                    child: const Icon(Icons.search, color: Colors.blue),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
