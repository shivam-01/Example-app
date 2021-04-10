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

  CartBloc({@required this.itemRepository}) : super(const CartLoading());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is ShowItems) {
      yield* _loadCartItems();
    } else if (event is RemoveItem) {
      yield* _loadCartItems();
    }
  }

  Stream<CartState> _loadCartItems() async* {
    try {
      final _selectedItems = await itemRepository.getSelectedItems;

      if (_selectedItems.isEmpty) {
        yield CartEmpty();
      } else {
        final data = ItemData(items: _selectedItems);
        yield CartLoaded(itemData: data);
      }
    } catch (_) {
      yield CartFailure();
    }
  }
}
