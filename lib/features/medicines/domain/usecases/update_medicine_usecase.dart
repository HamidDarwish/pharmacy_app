import '../entities/medicine_entity.dart';
import '../repositories/medicine_repository.dart';

class UpdateMedicineUseCase {
  final MedicineRepository repository;

  UpdateMedicineUseCase(this.repository);

  Future<void> call(MedicineEntity medicine) async {
    await repository.updateMedicine(medicine);
  }
}