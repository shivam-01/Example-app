import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo/bloc/cart/cart_bloc.dart';
import 'package:demo/item_model.dart';
import 'package:demo/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final ItemRepository itemRepository;
  final CartBloc cartBloc;

  ItemsBloc({
    @required this.itemRepository,
    @required this.cartBloc,
  }) : super(ItemsLoading());

  @override
  Stream<ItemsState> mapEventToState(
    ItemsEvent event,
  ) async* {
    if (event is GetItems) {
      yield* _mapGetItemsToState(event);
    } else if (event is UpdateItem) {
      yield* _mapUpdateItemToState(event);
    }
  }

  Stream<ItemsState> _mapGetItemsToState(GetItems event) async* {
    yield ItemsLoading();
    try {
      final _items = await itemRepository.loadItems();
      yield ItemsLoaded(items: _items);
      print('Yielded');
    } catch (_) {
      yield ItemsFailure();
    }
  }

  Stream<ItemsState> _mapUpdateItemToState(UpdateItem event) async* {
    try {
      _updateRepositoryItems(event.item);
      if (event.item.active) {
        cartBloc.add(ShowItems());
      } else {
        cartBloc.add(RemoveItem(itemId: event.item.id));
      }
      yield* _mapGetItemsToState(GetItems());
    } catch (_) {
      yield ItemsFailure();
    }
  }

  Item _updateRepositoryItems(Item item) => itemRepository.setItem = item;
}
