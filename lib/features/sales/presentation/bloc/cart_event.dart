part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCartEvent extends CartEvent {
  final String medicineId;
  final String medicineName;
  final int quantity;
  final double unitPrice;

  const AddToCartEvent({
    required this.medicineId,
    required this.medicineName,
    required this.quantity,
    required this.unitPrice,
  });

  @override
  List<Object> get props => [medicineId, medicineName, quantity, unitPrice];
}

class RemoveFromCartEvent extends CartEvent {
  final int index;

  const RemoveFromCartEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class UpdateQuantityEvent extends CartEvent {
  final int index;
  final int quantity;

  const UpdateQuantityEvent({
    required this.index,
    required this.quantity,
  });

  @override
  List<Object> get props => [index, quantity];
}

class ClearCartEvent extends CartEvent {
  const ClearCartEvent();
}