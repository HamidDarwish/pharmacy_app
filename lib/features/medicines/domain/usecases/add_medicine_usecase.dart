import '../entities/medicine_entity.dart';
import '../repositories/medicine_repository.dart';

class AddMedicineUseCase {
  final MedicineRepository repository;

  AddMedicineUseCase(this.repository);

  Future<void> call(MedicineEntity medicine) async {
    await repository.addMedicine(medicine);
  }
}