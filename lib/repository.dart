import 'package:demo/assets.dart';
import 'package:flutter/services.dart';

import 'item_model.dart';

class ItemRepository {
  List<Item> items = [];

  Future<List<Item>> loadItems() async {
    if (items.isNotEmpty) {
      return items;
    }
    var jsonString = await rootBundle.loadString(Assets.soundsJson);
    items.clear();
    items.addAll(itemFromJson(jsonString));

    return items;
  }

  set setItem(Item updatedItem) {
    var itemIndex = items.indexWhere((item) => item.id == updatedItem.id);
    items[itemIndex] = updatedItem;
  }

  Future<List<Item>> get getSelectedItems async =>
      items.where((sound) => sound.active).toList();
}
