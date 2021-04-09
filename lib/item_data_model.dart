import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'item_model.dart';

class ItemData extends Equatable {
  final List<Item> items;

  ItemData({@required this.items});

  @override
  List<Object> get props => [items];
}
