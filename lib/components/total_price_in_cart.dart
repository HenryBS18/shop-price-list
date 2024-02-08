import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_price_list/bloc/cart_bloc/cart_bloc.dart';
import 'package:shop_price_list/utils/format_currency.dart';

class TotalPriceInCart extends StatefulWidget {
  const TotalPriceInCart({Key? key}) : super(key: key);

  @override
  _TotalPriceInCardState createState() => _TotalPriceInCardState();
}

class _TotalPriceInCardState extends State<TotalPriceInCart> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, int>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.black, // border color
                width: 1.0, // border width
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                formatCurrency(state),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      },
    );
  }
}
