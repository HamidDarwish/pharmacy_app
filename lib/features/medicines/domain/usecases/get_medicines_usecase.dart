import '../entities/medicine_entity.dart';
import '../repositories/medicine_repository.dart';

class GetMedicinesUseCase {
  final MedicineRepository repository;

  GetMedicinesUseCase(this.repository);

  Future<List<MedicineEntity>> call() async {
    return await repository.getMedicines();
  }
}