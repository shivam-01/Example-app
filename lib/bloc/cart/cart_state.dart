part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartEmpty extends CartState {
  const CartEmpty();
}

class CartLoaded extends CartState {
  final ItemData itemData;

  CartLoaded({@required this.itemData});

  @override
  List<Object> get props => [itemData];
}

class CartFailure extends CartState {}
