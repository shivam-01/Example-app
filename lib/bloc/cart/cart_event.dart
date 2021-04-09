part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class ShowItems extends CartEvent {}

class RemoveItem extends CartEvent {
  final String itemId;

  RemoveItem({@required this.itemId});

  @override
  List<Object> get props => [itemId];
}
