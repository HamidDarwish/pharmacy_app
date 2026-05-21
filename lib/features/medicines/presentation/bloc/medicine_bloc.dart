import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/medicine_entity.dart';
import '../../domain/usecases/get_medicines_usecase.dart';
import '../../domain/usecases/add_medicine_usecase.dart';
import '../../domain/usecases/update_medicine_usecase.dart';
import '../../domain/usecases/delete_medicine_usecase.dart';
import '../../domain/usecases/search_medicine_usecase.dart';

part 'medicine_event.dart';
part 'medicine_state.dart';

class MedicineBloc extends Bloc<MedicineEvent, MedicineState> {
  final GetMedicinesUseCase getMedicinesUseCase;
  final AddMedicineUseCase addMedicineUseCase;
  final UpdateMedicineUseCase updateMedicineUseCase;
  final DeleteMedicineUseCase deleteMedicineUseCase;
  final SearchMedicineUseCase searchMedicineUseCase;

  MedicineBloc({
    required this.getMedicinesUseCase,
    required this.addMedicineUseCase,
    required this.updateMedicineUseCase,
    required this.deleteMedicineUseCase,
    required this.searchMedicineUseCase,
  }) : super(const MedicineInitial()) {
    on<GetMedicinesEvent>(_onGetMedicines);
    on<AddMedicineEvent>(_onAddMedicine);
    on<UpdateMedicineEvent>(_onUpdateMedicine);
    on<DeleteMedicineEvent>(_onDeleteMedicine);
    on<SearchMedicineEvent>(_onSearchMedicine);
  }

  Future<void> _onGetMedicines(
      GetMedicinesEvent event,
      Emitter<MedicineState> emit,
      ) async {
    emit(const MedicineLoading());
    try {
      final medicines = await getMedicinesUseCase();
      emit(MedicineLoaded(medicines));
    } catch (e) {
      emit(MedicineError(e.toString()));
    }
  }

  Future<void> _onAddMedicine(
      AddMedicineEvent event,
      Emitter<MedicineState> emit,
      ) async {
    try {
      await addMedicineUseCase(event.medicine);
      final medicines = await getMedicinesUseCase();
      emit(MedicineLoaded(medicines));
    } catch (e) {
      emit(MedicineError(e.toString()));
    }
  }

  Future<void> _onUpdateMedicine(
      UpdateMedicineEvent event,
      Emitter<MedicineState> emit,
      ) async {
    try {
      await updateMedicineUseCase(event.medicine);
      final medicines = await getMedicinesUseCase();
      emit(MedicineLoaded(medicines));
    } catch (e) {
      emit(MedicineError(e.toString()));
    }
  }

  Future<void> _onDeleteMedicine(
      DeleteMedicineEvent event,
      Emitter<MedicineState> emit,
      ) async {
    try {
      await deleteMedicineUseCase(event.medicineId);
      final medicines = await getMedicinesUseCase();
      emit(MedicineLoaded(medicines));
    } catch (e) {
      emit(MedicineError(e.toString()));
    }
  }

  Future<void> _onSearchMedicine(
      SearchMedicineEvent event,
      Emitter<MedicineState> emit,
      ) async {
    emit(const MedicineLoading());
    try {
      final medicines = await searchMedicineUseCase(event.query);
      emit(MedicineLoaded(medicines));
    } catch (e) {
      emit(MedicineError(e.toString()));
    }
  }
}