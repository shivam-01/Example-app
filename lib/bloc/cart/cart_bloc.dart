import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo/item_data_model.dart';
import 'package:demo/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ItemRepository itemRepository;

  CartBloc({@required this.itemRepository}) : super(CartLoading());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is ShowItems) {
      yield* _mapShowItemsToState(event);
    } else if (event is RemoveItem) {
      yield* _mapRemoveItemToState(event);
    }
  }

  Stream<CartState> _mapShowItemsToState(ShowItems event) async* {
    try {
      final _selectedItems = await itemRepository.getSelectedItems;

      if (_selectedItems.isNotEmpty) {
        final data = ItemData(items: _selectedItems);

        yield CartLoaded(itemData: data);
      } else {
        yield CartLoading();
      }
    } catch (_) {
      yield CartFailure();
    }
  }

  Stream<CartState> _mapRemoveItemToState(RemoveItem event) async* {
    try {
      final _selectedSounds = await itemRepository.getSelectedItems;

      if (_selectedSounds.isEmpty) {
        yield CartLoading();
      } else {
        yield* _mapShowItemsToState(ShowItems());
      }
    } catch (_) {
      yield CartFailure();
    }
  }
}
