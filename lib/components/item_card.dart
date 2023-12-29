import 'package:flutter/material.dart';
import 'package:shop_price_list/components/edit_item_dialog.dart';
import 'package:shop_price_list/components/modal_bottom_item.dart';
import 'package:shop_price_list/db/database.dart';
import 'package:shop_price_list/utils/format_currency.dart';

class ItemCard extends StatefulWidget {
  final int id;
  final String name;
  final int price;
  final VoidCallback refresh;

  const ItemCard({Key? key, required this.id, required this.name, required this.price, required this.refresh})
      : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  AppDb db = AppDb();

  Future<Item> getItemById(int id) => db.getItemByIdRepo(id);
  Future<int> deleteItemById(int id) => db.deleteItemByIdRepo(id);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        final storedContext = context;

        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ModalBottomItem(
                      icon: Icons.edit,
                      title: "Edit",
                      onTap: () async {
                        print("edit");

                        final Item item = await getItemById(widget.id);

                        showDialog(
                          context: storedContext,
                          builder: (context) {
                            return EditItemDialog(
                              item: item,
                              onUpdate: () {
                                widget.refresh.call();
                              },
                            );
                          },
                        );
                      }),
                  ModalBottomItem(
                      icon: Icons.delete,
                      title: "Delete",
                      onTap: () async {
                        print("delete");

                        await deleteItemById(widget.id);

                        widget.refresh.call();
                      }),
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
              Text(widget.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Card(
                color: Color.fromARGB(255, 136, 220, 41),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(formatCurrency(widget.price), style: TextStyle(fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
