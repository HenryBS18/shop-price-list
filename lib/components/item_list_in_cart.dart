import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_price_list/bloc/cart_bloc/cart_bloc.dart';
import 'package:shop_price_list/bloc/items_bloc/items_bloc.dart';
import 'package:shop_price_list/components/item_in_cart_card.dart';

class ItemListInCart extends StatefulWidget {
  const ItemListInCart({Key? key}) : super(key: key);

  @override
  _ItemListInCartState createState() => _ItemListInCartState();
}

class _ItemListInCartState extends State<ItemListInCart> {
  @override
  void initState() {
    super.initState();

    context.read<CartBloc>().add(ResetTotalPriceEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsState>(
      builder: (context, state) {
        if (state is ItemsLoading) {
          return const Expanded(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is ItemsSuccess && state.items.isNotEmpty) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                return ItemInCartCard(
                  id: state.items[index].id,
                  name: state.items[index].name,
                  price: state.items[index].price,
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
