import '../../domain/entities/medicine_entity.dart';
import '../../domain/repositories/medicine_repository.dart';
import '../models/medicine_model.dart';
import '../datasources/medicine_local_datasource.dart';

class MedicineRepositoryImpl implements MedicineRepository {
  final MedicineLocalDataSource localDataSource;

  MedicineRepositoryImpl(this.localDataSource);

  @override
  Future<List<MedicineEntity>> getMedicines() async {
    return await localDataSource.getMedicines();
  }

  @override
  Future<MedicineEntity?> getMedicineById(String id) async {
    return await localDataSource.getMedicineById(id);
  }

  @override
  Future<void> addMedicine(MedicineEntity medicine) async {
    final model = MedicineModel(
      id: medicine.id,
      name: medicine.name,
      genericName: medicine.genericName,
      barcode: medicine.barcode,
      quantity: medicine.quantity,
      minQuantity: medicine.minQuantity,
      unitPrice: medicine.unitPrice,
      expiryDate: medicine.expiryDate,
      batch: medicine.batch,
      category: medicine.category,
      manufacturer: medicine.manufacturer,
      createdAt: medicine.createdAt,
      updatedAt: medicine.updatedAt,
    );
    await localDataSource.addMedicine(model);
  }

  @override
  Future<void> updateMedicine(MedicineEntity medicine) async {
    final model = MedicineModel(
      id: medicine.id,
      name: medicine.name,
      genericName: medicine.genericName,
      barcode: medicine.barcode,
      quantity: medicine.quantity,
      minQuantity: medicine.minQuantity,
      unitPrice: medicine.unitPrice,
      expiryDate: medicine.expiryDate,
      batch: medicine.batch,
      category: medicine.category,
      manufacturer: medicine.manufacturer,
      createdAt: medicine.createdAt,
      updatedAt: medicine.updatedAt,
    );
    await localDataSource.updateMedicine(model);
  }

  @override
  Future<void> deleteMedicine(String id) async {
    await localDataSource.deleteMedicine(id);
  }

  @override
  Future<List<MedicineEntity>> searchMedicines(String query) async {
    return await localDataSource.searchMedicines(query);
  }
}