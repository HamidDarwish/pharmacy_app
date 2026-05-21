import '../entities/medicine_entity.dart';
import '../repositories/medicine_repository.dart';

class SearchMedicineUseCase {
  final MedicineRepository repository;

  SearchMedicineUseCase(this.repository);

  Future<List<MedicineEntity>> call(String query) async {
    return await repository.searchMedicines(query);
  }
}