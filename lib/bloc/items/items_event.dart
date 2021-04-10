part of 'items_bloc.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object> get props => [];
}

class GetItems extends ItemsEvent {}

class ItemToggled extends ItemsEvent {
  final Item item;

  const ItemToggled({
    @required this.item,
  }) : assert(item != null);

  @override
  List<Object> get props => [item];
}
