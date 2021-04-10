import 'package:demo/bloc/items/items_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cart/cart_bloc.dart';
import 'shared/shared.dart';

class CartPage extends StatelessWidget {
  const CartPage._({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _Cart();
  }

  static Route route() => MaterialPageRoute(
        builder: (_) => const CartPage._(),
      );
}

class _Cart extends StatelessWidget {
  const _Cart({Key key}) : super(key: key);

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
            children: const [
              Expanded(
                child: _CartList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  const _CartList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartEmpty) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is CartFailure) {
          return const Center(
            child: Text('Oops!'),
          );
        }
        if (state is CartEmpty) {
          return const Empty();
        }
        if (state is CartLoaded) {
          final items = state.itemData.items;
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              final item = items[index];
              return ListTile(
                trailing: IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    context.read<ItemsBloc>().add(ItemToggled(item: item));
                  },
                ),
                title: Text(
                  item.title,
                ),
              );
            },
          );
        }

        return const Loader();
      },
    );
  }
}
