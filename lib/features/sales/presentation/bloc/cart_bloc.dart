import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class SaleItem extends Equatable {
  final String medicineId;
  final String medicineName;
  final int quantity;
  final double unitPrice;
  final String? batchNumber;

  const SaleItem({
    required this.medicineId,
    required this.medicineName,
    required this.quantity,
    required this.unitPrice,
    this.batchNumber,
  });

  double get totalPrice => unitPrice * quantity;

  SaleItem copyWith({
    String? medicineId,
    String? medicineName,
    int? quantity,
    double? unitPrice,
    String? batchNumber,
  }) {
    return SaleItem(
      medicineId: medicineId ?? this.medicineId,
      medicineName: medicineName ?? this.medicineName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      batchNumber: batchNumber ?? this.batchNumber,
    );
  }

  @override
  List<Object?> get props => [
    medicineId,
    medicineName,
    quantity,
    unitPrice,
    batchNumber,
  ];
}

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartInitial()) {
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateQuantityEvent>(_onUpdateQuantity);
    on<ClearCartEvent>(_onClearCart);
  }

  Future<void> _onAddToCart(
      AddToCartEvent event,
      Emitter<CartState> emit,
      ) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final items = List<SaleItem>.from(currentState.items);

      final existingIndex = items.indexWhere(
            (item) => item.medicineId == event.medicineId,
      );

      if (existingIndex >= 0) {
        items[existingIndex] = items[existingIndex].copyWith(
          quantity: items[existingIndex].quantity + event.quantity,
        );
      } else {
        items.add(SaleItem(
          medicineId: event.medicineId,
          medicineName: event.medicineName,
          quantity: event.quantity,
          unitPrice: event.unitPrice,
        ));
      }

      emit(CartLoaded(items: items));
    } else {
      emit(CartLoaded(
        items: [
          SaleItem(
            medicineId: event.medicineId,
            medicineName: event.medicineName,
            quantity: event.quantity,
            unitPrice: event.unitPrice,
          )
        ],
      ));
    }
  }

  Future<void> _onRemoveFromCart(
      RemoveFromCartEvent event,
      Emitter<CartState> emit,
      ) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final items = List<SaleItem>.from(currentState.items)
        ..removeAt(event.index);

      if (items.isEmpty) {
        emit(const CartInitial());
      } else {
        emit(CartLoaded(items: items));
      }
    }
  }

  Future<void> _onUpdateQuantity(
      UpdateQuantityEvent event,
      Emitter<CartState> emit,
      ) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final items = List<SaleItem>.from(currentState.items);

      if (event.quantity <= 0) {
        items.removeAt(event.index);
        if (items.isEmpty) {
          emit(const CartInitial());
          return;
        }
      } else {
        items[event.index] = items[event.index].copyWith(
          quantity: event.quantity,
        );
      }

      emit(CartLoaded(items: items));
    }
  }

  Future<void> _onClearCart(
      ClearCartEvent event,
      Emitter<CartState> emit,
      ) async {
    emit(const CartInitial());
  }
}