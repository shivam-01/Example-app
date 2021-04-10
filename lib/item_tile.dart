import 'package:demo/bloc/items/items_bloc.dart';
import 'package:demo/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({Key key, this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      tileColor: item.active ? Colors.redAccent : Colors.blueAccent,
      onTap: () {
        context.read<ItemsBloc>().add(ItemToggled(item: item));
      },
    );
  }
}
