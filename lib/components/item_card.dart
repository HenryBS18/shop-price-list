import 'package:flutter/material.dart';
import 'package:shop_price_list/components/delete_item_dialog.dart';
import 'package:shop_price_list/components/edit_item_dialog.dart';
import 'package:shop_price_list/components/modal_bottom_item.dart';
import 'package:shop_price_list/db/database.dart';
import 'package:shop_price_list/utils/format_currency.dart';

class ItemCard extends StatefulWidget {
  final int id;
  final String name;
  final int price;
  final VoidCallback refresh;

  const ItemCard({Key? key, required this.id, required this.name, required this.price, required this.refresh}) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  AppDb db = AppDb();

  Future<Item> getItemById(int id) => db.getItemByIdRepo(id);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        final storedContext = context;

        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <ModalBottomItem>[
                  ModalBottomItem(
                    icon: Icons.edit,
                    title: "Edit",
                    onTap: () async {
                      final Item item = await getItemById(widget.id);

                      showDialog(
                        context: storedContext,
                        builder: (context) {
                          return EditItemDialog(
                            item: item,
                            refresh: () async {
                              widget.refresh.call();
                            },
                          );
                        },
                      );
                    },
                  ),
                  ModalBottomItem(
                    icon: Icons.delete,
                    title: "Delete",
                    onTap: () {
                      showDialog(
                        context: storedContext,
                        builder: (context) {
                          return DeleteItemDialog(
                            id: widget.id,
                            name: widget.name,
                            refresh: widget.refresh,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Card(
                color: const Color.fromARGB(255, 136, 220, 41),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(formatCurrency(widget.price), style: const TextStyle(fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
