import 'package:demo/bloc/cart/cart_bloc.dart';
import 'package:demo/bloc/items/items_bloc.dart';
import 'package:demo/item_tile.dart';
import 'package:demo/list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<ItemsBloc, ItemsState>(
                  // ignore: missing_return
                  builder: (context, state) {
                    if (state is ItemsLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ItemsLoaded) {
                      print('Items Loaded');
                      return GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                        childAspectRatio: 0.6,
                        children: [
                          for (var item in state.items) ItemTile(item: item),
                        ],
                      );
                    } else if (state is ItemsFailure) {
                      return Center(
                        child: Text(
                          'Unexpected Failure, Cannot Load Items',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CartButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is CartLoading) {
          return SizedBox.shrink();
        } else if (state is CartLoaded) {
          print('Cart Loaded');
          return TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return ListPage(
                    items: state.itemData.items,
                  );
                }),
              );
            },
            child: Text('Go To Cart'),
          );
        } else if (state is CartFailure) {
          return Center(
            child: Text(
              'Unexpected Failure, Cannot Load Cart',
              style: Theme.of(context).textTheme.headline6,
            ),
          );
        }
      },
    );
  }
}
