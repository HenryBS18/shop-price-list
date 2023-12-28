import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({Key? key}) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Aqua"),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      print("edit");
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                  onPressed: () {
                    print("delete");
                  },
                  icon: const Icon(Icons.delete),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
