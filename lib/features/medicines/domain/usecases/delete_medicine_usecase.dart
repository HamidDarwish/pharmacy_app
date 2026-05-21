import '../repositories/medicine_repository.dart';

class DeleteMedicineUseCase {
  final MedicineRepository repository;

  DeleteMedicineUseCase(this.repository);

  Future<void> call(String id) async {
    await repository.deleteMedicine(id);
  }
}