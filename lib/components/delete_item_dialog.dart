import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_price_list/bloc/items_bloc/items_bloc.dart';
import 'package:shop_price_list/db/database.dart';

class DeleteItemDialog extends StatefulWidget {
  final int id;
  final String name;

  const DeleteItemDialog({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  State<DeleteItemDialog> createState() => _DeleteItemDialogState();
}

class _DeleteItemDialogState extends State<DeleteItemDialog> {
  final AppDb db = AppDb();

  Future<int> deleteItemById(int id) => db.deleteItemByIdRepo(id);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete ${widget.name}?"),
      actions: [
        TextButton(
          onPressed: () async {
            final result = await deleteItemById(widget.id);

            if (!result.isNaN) {
              // Refetch Items
              context.read<ItemsBloc>().add(FetchItemsEvent());

              Navigator.of(context).pop();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Item deleted successfully!'),
                  duration: Duration(seconds: 2),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to delete item. Please try again.'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: const Text("Delete"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
