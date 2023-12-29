import 'package:flutter/material.dart';
import 'package:shop_price_list/db/database.dart';

class EditItemDialog extends StatefulWidget {
  final Item item;
  final void Function()? onUpdate;

  const EditItemDialog({Key? key, required this.item, this.onUpdate}) : super(key: key);

  @override
  _EditItemDialogState createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
  AppDb db = AppDb();
  final _formKey = GlobalKey<FormState>();

  Future<int> updateItemById(int id, Item item) => db.updateItemByIdRepo(id, item);

  late String name;
  late String type;
  late int price;

  @override
  void initState() {
    super.initState();

    name = widget.item.name;
    type = widget.item.type;
    price = widget.item.price;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Add Item"),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
            iconSize: 32,
          )
        ],
      ),
      content: Form(
        key: _formKey,
        child: SizedBox(
          height: 250,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: "Name", border: OutlineInputBorder()),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: price.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Price", border: OutlineInputBorder()),
                onChanged: (value) {
                  setState(() {
                    price = int.tryParse(value) ?? 0;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Price is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const SizedBox(width: 8),
                  const Text(
                    "Type: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(width: 16),
                  DropdownButton(
                    value: type,
                    items: [
                      DropdownMenuItem(
                        value: "piece",
                        onTap: () {
                          type = "piece";
                        },
                        child: const SizedBox(
                          width: 165,
                          child: Text("Piece"),
                        ),
                      ),
                      DropdownMenuItem(
                        value: "box",
                        onTap: () {
                          type = "box";
                        },
                        child: const SizedBox(
                          width: 165,
                          child: Text("Box"),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        type = value!;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            minimumSize: MaterialStateProperty.all(const Size(double.infinity, 48.0)),
          ),
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              // Form is valid, show loading indicator
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );

              final Item item = Item(
                id: widget.item.id,
                name: name,
                type: type,
                price: price,
              );

              // Attempt to update the item
              final result = await updateItemById(widget.item.id, item);
              print("Updated: $result");

              if (!result.isNaN) {
                // Dismiss the loading indicator
                Navigator.of(context).pop();

                // Show success message (you can customize this)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Item updated successfully!'),
                    duration: Duration(seconds: 2),
                  ),
                );

                widget.onUpdate?.call();

                Navigator.of(context).pop();
              } else {
                // Show error message (you can customize this)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to update item. Please try again.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            }
          },
          child: const Text(
            'Save',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      ],
    );
  }
}
