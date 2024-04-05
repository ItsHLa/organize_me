part of 'appoitment_cubit.dart';

@immutable
sealed class AppoitmentState {}

final class AppoitmentInitial extends AppoitmentState {}

// for ui
final class AppoitmentUpdated extends AppoitmentState {
  final List<Appointment> appointments;

  AppoitmentUpdated({required this.appointments});
}

// for add appoitment
final class AppoitmentAddedSuccsess extends AppoitmentState {}

final class AppoitmentAddedFailed extends AppoitmentState {
  final String msg;

  AppoitmentAddedFailed({required this.msg});
}

// when deleting appoitment
final class AppoitmentDeletedSuccsess extends AppoitmentState {}

final class AppoitmentDeletedFailed extends AppoitmentState {}
