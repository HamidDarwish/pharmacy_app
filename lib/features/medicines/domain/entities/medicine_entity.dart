import 'package:equatable/equatable.dart';

class MedicineEntity extends Equatable {
  final String id;
  final String name;
  final String genericName;
  final String barcode;
  final int quantity;
  final int minQuantity;
  final double unitPrice;
  final DateTime expiryDate;
  final String batch;
  final String category;
  final String manufacturer;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MedicineEntity({
    required this.id,
    required this.name,
    required this.genericName,
    required this.barcode,
    required this.quantity,
    required this.minQuantity,
    required this.unitPrice,
    required this.expiryDate,
    required this.batch,
    required this.category,
    required this.manufacturer,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    genericName,
    barcode,
    quantity,
    minQuantity,
    unitPrice,
    expiryDate,
    batch,
    category,
    manufacturer,
    createdAt,
    updatedAt,
  ];
}