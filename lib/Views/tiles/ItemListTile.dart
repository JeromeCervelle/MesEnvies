import 'package:flutter/material.dart';
import 'package:mes_envies/Models/ItemList.dart';

class ItemListTile extends StatelessWidget {
  ItemList itemList;
  Function(ItemList) onPressed;
  Function(ItemList) onDelete;

  ItemListTile({super.key, required this.itemList, required this.onPressed, required this.onDelete});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(itemList.name),
      onTap: (() => onPressed(itemList)),
      trailing: IconButton(
        onPressed: (() => onDelete(itemList)),
        icon: const Icon(Icons.delete),
      ),
    );
  }
}