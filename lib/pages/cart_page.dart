import 'package:flutter/material.dart';
import 'package:shop_price_list/components/item_list_in_cart.dart';
import 'package:shop_price_list/components/total_price_in_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(children: [
        ItemListInCart(),
        TotalPriceInCart(),
      ]),
    );
  }
}
