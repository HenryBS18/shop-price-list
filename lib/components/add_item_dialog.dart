import 'package:flutter/material.dart';

class AddItemDialog extends StatefulWidget {
  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  String name = '';
  String price = '';
  String type = 'piece';

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
      content: SizedBox(
        height: 210,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Name", border: OutlineInputBorder()),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Price", border: OutlineInputBorder()),
              onChanged: (value) {
                setState(() {
                  price = value;
                });
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "Type: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  width: 16,
                ),
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
      actions: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            minimumSize: MaterialStateProperty.all(const Size(double.infinity, 48.0)),
          ),
          onPressed: () {
            Navigator.of(context).pop();
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
