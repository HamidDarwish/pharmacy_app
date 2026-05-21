import 'package:get_it/get_it.dart';
import 'core/database/database_service.dart';

// Medicines
import 'features/medicines/data/datasources/medicine_local_datasource.dart';
import 'features/medicines/data/repositories/medicine_repository_impl.dart';
import 'features/medicines/domain/repositories/medicine_repository.dart';
import 'features/medicines/domain/usecases/get_medicines_usecase.dart';
import 'features/medicines/domain/usecases/add_medicine_usecase.dart';
import 'features/medicines/domain/usecases/update_medicine_usecase.dart';
import 'features/medicines/domain/usecases/delete_medicine_usecase.dart';
import 'features/medicines/domain/usecases/search_medicine_usecase.dart';
import 'features/medicines/presentation/bloc/medicine_bloc.dart';

// Sales
import 'features/sales/presentation/bloc/cart_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ============ Core Services ============

  // Database
  final databaseService = DatabaseService();
  getIt.registerSingleton<DatabaseService>(databaseService);

  // ============ Data Sources ============

  getIt.registerSingleton<MedicineLocalDataSource>(
    MedicineLocalDataSource(getIt<DatabaseService>()),
  );

  // ============ Repositories ============

  // Medicine
  getIt.registerSingleton<MedicineRepository>(
    MedicineRepositoryImpl(getIt<MedicineLocalDataSource>()),
  );

  // ============ Use Cases ============

  // Medicine
  getIt.registerSingleton<GetMedicinesUseCase>(
    GetMedicinesUseCase(getIt<MedicineRepository>()),
  );

  getIt.registerSingleton<AddMedicineUseCase>(
    AddMedicineUseCase(getIt<MedicineRepository>()),
  );

  getIt.registerSingleton<UpdateMedicineUseCase>(
    UpdateMedicineUseCase(getIt<MedicineRepository>()),
  );

  getIt.registerSingleton<DeleteMedicineUseCase>(
    DeleteMedicineUseCase(getIt<MedicineRepository>()),
  );

  getIt.registerSingleton<SearchMedicineUseCase>(
    SearchMedicineUseCase(getIt<MedicineRepository>()),
  );

  // ============ BLoCs ============

  getIt.registerFactory<MedicineBloc>(
        () => MedicineBloc(
      getMedicinesUseCase: getIt<GetMedicinesUseCase>(),
      addMedicineUseCase: getIt<AddMedicineUseCase>(),
      updateMedicineUseCase: getIt<UpdateMedicineUseCase>(),
      deleteMedicineUseCase: getIt<DeleteMedicineUseCase>(),
      searchMedicineUseCase: getIt<SearchMedicineUseCase>(),
    ),
  );

  getIt.registerFactory<CartBloc>(
        () => CartBloc(),
  );

  print('✅ Dependency Injection setup completed');
}