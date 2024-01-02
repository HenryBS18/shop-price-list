import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_price_list/bloc/items_bloc/items_bloc.dart';
import 'package:shop_price_list/bloc/search_bloc/search_bloc.dart';
import 'package:shop_price_list/components/item_card.dart';

class ItemPriceList extends StatefulWidget {
  const ItemPriceList({Key? key}) : super(key: key);

  @override
  _ItemPriceListState createState() => _ItemPriceListState();
}

class _ItemPriceListState extends State<ItemPriceList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, searchState) {
        return BlocBuilder<ItemsBloc, ItemsState>(
          builder: (context, itemsState) {
            if (itemsState is ItemsLoading) {
              return const Expanded(
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (itemsState is ItemsSuccess && itemsState.items.isNotEmpty) {
              return Expanded(
                child: ListView.builder(
                  itemCount: itemsState.items.length,
                  itemBuilder: (context, index) {
                    return ItemCard(
                      id: itemsState.items[index].id,
                      name: itemsState.items[index].name,
                      price: itemsState.items[index].price,
                    );
                  },
                ),
              );
            }

            if (searchState is SearchValue && searchState.input.isNotEmpty) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(fontSize: 24, color: Colors.black),
                    children: [
                      const TextSpan(text: 'Item "'),
                      TextSpan(
                        text: searchState.input,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: '" not found'),
                    ],
                  ),
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
      },
    );
  }
}
