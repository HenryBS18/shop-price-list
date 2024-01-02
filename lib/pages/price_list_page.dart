import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_price_list/bloc/items_bloc/items_bloc.dart';
import 'package:shop_price_list/bloc/search_bloc/search_bloc.dart';
import 'package:shop_price_list/components/item_price_list.dart';
import 'package:shop_price_list/utils/debouncer.dart';

class PriceListPage extends StatefulWidget {
  const PriceListPage({Key? key}) : super(key: key);

  @override
  _PriceListPageState createState() => _PriceListPageState();
}

class _PriceListPageState extends State<PriceListPage> with WidgetsBindingObserver {
  late FocusNode _searchFocusNode;
  final Debouncer debouncer = Debouncer();

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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Xiaomi 12 Lite",
              ),
              onChanged: (value) {
                debouncer.run(const Duration(microseconds: 500), () {
                  context.read<SearchBloc>().add(SearchChangeEvent(input: value));

                  if (value.isEmpty) {
                    context.read<ItemsBloc>().add(FetchItemsEvent());
                  }

                  context.read<ItemsBloc>().add(FetchItemsLikeEvent(input: value));
                });
              },
            ),
            const SizedBox(height: 16),
            const ItemPriceList(),
          ],
        ),
      ),
    );
  }
}
