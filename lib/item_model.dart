import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

List<Item> itemFromJson(String str) =>
    List<Item>.from(json.decode(str).map((item) => Item.fromJson(item)));

class Item extends Equatable {
  final String id;
  final String title;
  final bool active;

  Item({
    @required this.id,
    @required this.title,
    this.active = false,
  });

  Item copyWith({
    String id,
    String title,
    bool active,
  }) =>
      Item(
        id: id ?? this.id,
        title: title ?? this.title,
        active: active ?? this.active,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'],
        title: json['title'],
      );

  @override
  List<Object> get props => [id, title, active];
}
