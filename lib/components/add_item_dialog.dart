import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_price_list/bloc/items_bloc/items_bloc.dart';
import 'package:shop_price_list/db/database.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({super.key});

  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  String name = '';
  String type = 'piece';
  int price = 0;

  final AppDb db = AppDb();
  final _formKey = GlobalKey<FormState>();

  Future createItem() => db.createItemRepo(name, type, price);
  Future<List<Item>> getAllItems() => db.getAllItemsRepo();

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
              const SizedBox(
                height: 8,
              ),
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
              ),
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
              final success = await createItem();

              if (success != null) {
                // Refetch Items
                context.read<ItemsBloc>().add(FetchItemsEvent());

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Item added successfully!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to add item. Please try again.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            }
          },
          child: const Text(
            'Add',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      ],
    );
  }
}
