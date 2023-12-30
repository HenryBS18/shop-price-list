import 'package:flutter/material.dart';
import 'package:shop_price_list/components/item_price_list.dart';
import 'package:shop_price_list/db/database.dart';

class PriceListPage extends StatefulWidget {
  final Future<List<Item>> items;
  final VoidCallback refresh;

  const PriceListPage({Key? key, required this.items, required this.refresh}) : super(key: key);

  @override
  _PriceListPageState createState() => _PriceListPageState();
}

class _PriceListPageState extends State<PriceListPage> with WidgetsBindingObserver {
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_searchFocusNode.hasFocus) {
          _searchFocusNode.unfocus();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  "Search Item:",
                  style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            TextField(
              focusNode: _searchFocusNode,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Coca Cola",
              ),
            ),
            const SizedBox(height: 16),
            ItemPriceList(items: widget.items, refresh: widget.refresh),
            const SizedBox(height: 32)
          ],
        ),
      ),
    );
  }
}
