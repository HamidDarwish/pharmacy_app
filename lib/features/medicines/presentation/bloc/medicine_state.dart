part of 'medicine_bloc.dart';

abstract class MedicineState extends Equatable {
  const MedicineState();

  @override
  List<Object> get props => [];
}

class MedicineInitial extends MedicineState {
  const MedicineInitial();
}

class MedicineLoading extends MedicineState {
  const MedicineLoading();
}

class MedicineLoaded extends MedicineState {
  final List<MedicineEntity> medicines;

  const MedicineLoaded(this.medicines);

  @override
  List<Object> get props => [medicines];
}

class MedicineAdded extends MedicineState {
  const MedicineAdded();
}

class MedicineUpdated extends MedicineState {
  const MedicineUpdated();
}

class MedicineDeleted extends MedicineState {
  const MedicineDeleted();
}

class MedicineError extends MedicineState {
  final String message;

  const MedicineError(this.message);

  @override
  List<Object> get props => [message];
}