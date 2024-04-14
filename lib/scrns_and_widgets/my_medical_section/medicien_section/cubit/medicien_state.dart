part of 'medicien_cubit.dart';

@immutable
sealed class MedicienState {
  final List meds;

  const MedicienState({required this.meds});
}

final class MedInitial extends MedicienState {
  const MedInitial({required super.meds});
}

final class AddMedSuccses extends MedicienState {
  const AddMedSuccses({required super.meds});
}

final class AddMedsFailed extends MedicienState {
  const AddMedsFailed({required super.meds});
}

final class DeleteMedsSuccses extends MedicienState {
  const DeleteMedsSuccses({required super.meds});
}

final class DeleteMedsFailed extends MedicienState {
  const DeleteMedsFailed({required super.meds});
}

final class LoadMeds extends MedicienState {
  const LoadMeds({required super.meds});
}

final class MedsLoaded extends MedicienState {
  const MedsLoaded({required super.meds});
}
