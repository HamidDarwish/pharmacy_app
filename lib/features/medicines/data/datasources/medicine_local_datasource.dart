import '../../../../core/database/database_service.dart';
import '../models/medicine_model.dart';

class MedicineLocalDataSource {
  final DatabaseService databaseService;

  MedicineLocalDataSource(this.databaseService);

  Future<List<MedicineModel>> getMedicines() async {
    final db = databaseService.database;
    final result = await db.query('medicines');
    return result.map((map) => MedicineModel.fromMap(map)).toList();
  }

  Future<MedicineModel?> getMedicineById(String id) async {
    final db = databaseService.database;
    final result = await db.query(
      'medicines',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return MedicineModel.fromMap(result.first);
  }

  Future<void> addMedicine(MedicineModel medicine) async {
    final db = databaseService.database;
    await db.insert('medicines', medicine.toMap());
  }

  Future<void> updateMedicine(MedicineModel medicine) async {
    final db = databaseService.database;
    await db.update(
      'medicines',
      medicine.toMap(),
      where: 'id = ?',
      whereArgs: [medicine.id],
    );
  }

  Future<void> deleteMedicine(String id) async {
    final db = databaseService.database;
    await db.delete(
      'medicines',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<MedicineModel>> searchMedicines(String query) async {
    final db = databaseService.database;
    final result = await db.query(
      'medicines',
      where: 'name LIKE ? OR genericName LIKE ? OR barcode LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
    );
    return result.map((map) => MedicineModel.fromMap(map)).toList();
  }
}