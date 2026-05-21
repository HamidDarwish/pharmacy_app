import '../entities/medicine_entity.dart';

abstract class MedicineRepository {
  Future<List<MedicineEntity>> getMedicines();
  Future<MedicineEntity?> getMedicineById(String id);
  Future<void> addMedicine(MedicineEntity medicine);
  Future<void> updateMedicine(MedicineEntity medicine);
  Future<void> deleteMedicine(String id);
  Future<List<MedicineEntity>> searchMedicines(String query);
}