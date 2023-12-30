import 'package:flutter/material.dart';

class ModalBottomItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ModalBottomItem({Key? key, required this.icon, required this.title, required this.onTap}) : super(key: key);

  @override
  _ModalBottomItemState createState() => _ModalBottomItemState();
}

class _ModalBottomItemState extends State<ModalBottomItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(widget.icon, size: 32),
      title: Text(
        widget.title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        Navigator.pop(context);

        widget.onTap.call();
      },
    );
  }
}
