import 'package:demo/bloc/items/items_bloc.dart';
import 'package:demo/get_it.dart';
import 'package:demo/item_model.dart';
import 'package:flutter/material.dart';

class ItemTile extends StatefulWidget {
  final Item item;

  const ItemTile({Key key, this.item}) : super(key: key);
  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  bool active;

  @override
  void initState() {
    super.initState();
    active = widget.item.active;
  }

  void _onItemTap() {
    setState(() {
      active = !active;
    });

    getIt<ItemsBloc>()
        .add(UpdateItem(item: widget.item.copyWith(active: active)));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.item.title),
      tileColor: active ? Colors.redAccent : Colors.blueAccent,
      onTap: () {
        _onItemTap();
      },
    );
  }
}
