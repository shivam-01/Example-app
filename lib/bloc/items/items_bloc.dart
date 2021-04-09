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
      yield* _mapGetItemsToState();
    } else if (event is ItemToggled) {
      yield* _mapItemToggledToState(event);
    }
  }

  Stream<ItemsState> _mapGetItemsToState() async* {
    yield ItemsLoading();
    yield* _loadItems();
  }

  Stream<ItemsState> _loadItems() async* {
    try {
      final _items = await itemRepository.loadItems();
      yield ItemsLoaded(items: List.from(_items));
    } catch (_) {
      yield ItemsFailure();
    }
  }

  Stream<ItemsState> _mapItemToggledToState(ItemToggled event) async* {
    try {
      final item = event.item;
      _updateRepositoryItems(item.copyWith(active: !item.active));
      if (item.active) {
        cartBloc.add(RemoveItem(itemId: item.id));
      } else {
        cartBloc.add(ShowItems());
      }
      yield* _loadItems();
    } catch (_) {
      yield ItemsFailure();
    }
  }

  Item _updateRepositoryItems(Item item) => itemRepository.setItem = item;
}
