part of 'medicien_cubit.dart';

@immutable
sealed class MedicineState {
  final List<Med> meds;

  const MedicineState({required this.meds});
}

final class MedInitial extends MedicineState {
  const MedInitial({required super.meds});
}

final class AddMedSuccses extends MedicineState {
  const AddMedSuccses({required super.meds});
}

final class AddMedsFailed extends MedicineState {
  const AddMedsFailed({required super.meds});
}

final class DeleteMedsSuccses extends MedicineState {
  const DeleteMedsSuccses({required super.meds});
}

final class DeleteMedsFailed extends MedicineState {
  const DeleteMedsFailed({required super.meds});
}

final class LoadMeds extends MedicineState {
  const LoadMeds({required super.meds});
}

final class MedsLoaded extends MedicineState {
  const MedsLoaded({required super.meds});
}
