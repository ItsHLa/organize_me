part of 'medicien_cubit.dart';

@immutable
sealed class MedicienState {
  final List Meds;

  MedicienState({required this.Meds});
}

final class MedInitial extends MedicienState {
  MedInitial({required super.Meds});
}

final class AddMedSuccses extends MedicienState {
  AddMedSuccses({required super.Meds});
}

final class AddMedsFailed extends MedicienState {
  AddMedsFailed({required super.Meds});
}

final class DeleteMedsSuccses extends MedicienState {
  DeleteMedsSuccses({required super.Meds});
}

final class DeleteMedsFailed extends MedicienState {
  DeleteMedsFailed({required super.Meds});
}

final class LoadMeds extends MedicienState {
  LoadMeds({required super.Meds});
}

final class MedsLoaded extends MedicienState {
  MedsLoaded({required super.Meds});
}
