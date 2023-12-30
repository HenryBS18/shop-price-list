import 'package:flutter/material.dart';
import 'package:shop_price_list/components/item_card.dart';
import 'package:shop_price_list/db/database.dart';

class ItemPriceList extends StatefulWidget {
  final Future<List<Item>> items;
  final VoidCallback refresh;

  const ItemPriceList({Key? key, required this.items, required this.refresh}) : super(key: key);

  @override
  _ItemPriceListState createState() => _ItemPriceListState();
}

class _ItemPriceListState extends State<ItemPriceList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.items, // Use the Future for the builder
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ItemCard(
                  id: snapshot.data![index].id,
                  name: snapshot.data![index].name,
                  price: snapshot.data![index].price,
                  refresh: widget.refresh,
                );
              },
            ),
          );
        }

        return const Expanded(
          child: Center(
            child: Text(
              "No Data",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
