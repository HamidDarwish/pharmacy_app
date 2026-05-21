part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoaded extends CartState {
  final List<SaleItem> items;

  const CartLoaded({required this.items});

  @override
  List<Object> get props => [items];
}