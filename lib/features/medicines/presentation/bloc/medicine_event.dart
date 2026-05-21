part of 'medicine_bloc.dart';

abstract class MedicineEvent extends Equatable {
  const MedicineEvent();

  @override
  List<Object> get props => [];
}

class GetMedicinesEvent extends MedicineEvent {
  const GetMedicinesEvent();
}

class AddMedicineEvent extends MedicineEvent {
  final MedicineEntity medicine;

  const AddMedicineEvent({required this.medicine});

  @override
  List<Object> get props => [medicine];
}

class UpdateMedicineEvent extends MedicineEvent {
  final MedicineEntity medicine;

  const UpdateMedicineEvent({required this.medicine});

  @override
  List<Object> get props => [medicine];
}

class DeleteMedicineEvent extends MedicineEvent {
  final String medicineId;

  const DeleteMedicineEvent({required this.medicineId});

  @override
  List<Object> get props => [medicineId];
}

class SearchMedicineEvent extends MedicineEvent {
  final String query;

  const SearchMedicineEvent({required this.query});

  @override
  List<Object> get props => [query];
}