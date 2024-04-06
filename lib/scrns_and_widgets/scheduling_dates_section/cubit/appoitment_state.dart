part of 'appoitment_cubit.dart';

@immutable
sealed class AppoitmentState {
  final AppointmentDataSource appointmentDataSource;

  AppoitmentState({required this.appointmentDataSource});
}

final class AppoitmentInitial extends AppoitmentState {
  AppoitmentInitial({required super.appointmentDataSource});
}

// for add appoitment
final class AppoitmentAddedSuccsess extends AppoitmentState {
  AppoitmentAddedSuccsess({required super.appointmentDataSource});
}

final class AppoitmentAddedFailed extends AppoitmentState {
  final String msg;

  AppoitmentAddedFailed(
      {required this.msg, required super.appointmentDataSource});
}

// when deleting appoitment
final class AppoitmentDeletedSuccsess extends AppoitmentState {
  AppoitmentDeletedSuccsess({required super.appointmentDataSource});
}

final class AppoitmentDeletedFailed extends AppoitmentState {
  final String msg;

  AppoitmentDeletedFailed(
      {required this.msg, required super.appointmentDataSource});
}
