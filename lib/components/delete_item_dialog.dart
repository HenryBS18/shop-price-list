import 'package:flutter/material.dart';
import 'package:shop_price_list/db/database.dart';

class DeleteItemDialog extends StatefulWidget {
  final int id;
  final String name;
  final VoidCallback refresh;

  const DeleteItemDialog({Key? key, required this.id, required this.name, required this.refresh}) : super(key: key);

  @override
  State<DeleteItemDialog> createState() => _DeleteItemDialogState();
}

class _DeleteItemDialogState extends State<DeleteItemDialog> {
  AppDb db = AppDb();

  Future<int> deleteItemById(int id) => db.deleteItemByIdRepo(id);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete ${widget.name}?"),
      actions: [
        TextButton(
          onPressed: () async {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );

            final result = await deleteItemById(widget.id);

            // Close the progress indicator
            Navigator.of(context).pop();

            if (!result.isNaN) {
              widget.refresh.call();

              Navigator.of(context).pop();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Item deleted successfully!'),
                  duration: Duration(seconds: 2),
                ),
              );
            } else {
              Navigator.of(context).pop();

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
