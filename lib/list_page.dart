import 'package:demo/bloc/items/items_bloc.dart';
import 'package:demo/get_it.dart';
import 'package:flutter/material.dart';

import 'item_model.dart';

class ListPage extends StatefulWidget {
  final List<Item> items;

  const ListPage({Key key, this.items}) : super(key: key);
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Cart List Page',
            style: Theme.of(context).textTheme.headline6,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: widget.items.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      trailing: IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          getIt<ItemsBloc>().add(UpdateItem(
                            item: widget.items.elementAt(index).copyWith(
                                active: !widget.items.elementAt(index).active),
                          ));

                          setState(() {
                            widget.items.removeAt(index);
                          });
                          if (widget.items.isEmpty) {
                            Navigator.pop(context);
                          }
                        },
                      ),
                      title: Text(
                        widget.items.elementAt(index).title,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
