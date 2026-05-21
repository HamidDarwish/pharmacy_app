import '../../domain/entities/medicine_entity.dart';

class MedicineModel extends MedicineEntity {
  const MedicineModel({
    required String id,
    required String name,
    required String genericName,
    required String barcode,
    required int quantity,
    required int minQuantity,
    required double unitPrice,
    required DateTime expiryDate,
    required String batch,
    required String category,
    required String manufacturer,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
    id: id,
    name: name,
    genericName: genericName,
    barcode: barcode,
    quantity: quantity,
    minQuantity: minQuantity,
    unitPrice: unitPrice,
    expiryDate: expiryDate,
    batch: batch,
    category: category,
    manufacturer: manufacturer,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'genericName': genericName,
      'barcode': barcode,
      'quantity': quantity,
      'minQuantity': minQuantity,
      'unitPrice': unitPrice,
      'expiryDate': expiryDate.toIso8601String(),
      'batch': batch,
      'category': category,
      'manufacturer': manufacturer,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory MedicineModel.fromMap(Map<String, dynamic> map) {
    return MedicineModel(
      id: map['id'] as String,
      name: map['name'] as String,
      genericName: map['genericName'] as String? ?? '',
      barcode: map['barcode'] as String,
      quantity: map['quantity'] as int? ?? 0,
      minQuantity: map['minQuantity'] as int? ?? 10,
      unitPrice: (map['unitPrice'] as num).toDouble(),
      expiryDate: DateTime.parse(map['expiryDate'] as String),
      batch: map['batch'] as String? ?? '',
      category: map['category'] as String? ?? '',
      manufacturer: map['manufacturer'] as String? ?? '',
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }
}