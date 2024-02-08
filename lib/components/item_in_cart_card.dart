import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_price_list/bloc/cart_bloc/cart_bloc.dart';

class ItemInCartCard extends StatefulWidget {
  final int id;
  final String name;
  final int price;

  const ItemInCartCard({Key? key, required this.id, required this.name, required this.price}) : super(key: key);

  @override
  _ItemInCartCardState createState() => _ItemInCartCardState();
}

class _ItemInCartCardState extends State<ItemInCartCard> {
  int total = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (total != 0) {
                        total -= 1;
                        context.read<CartBloc>().add(DecrementTotalPriceEvent(decrement: widget.price));
                      }
                    });
                  },
                  icon: Icon(Icons.remove, color: Colors.white),
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.red)),
                ),
                const SizedBox(width: 16),
                Text(total.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    setState(() {
                      total += 1;
                      context.read<CartBloc>().add(IncrementTotalPriceEvent(increment: widget.price));
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.green)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
