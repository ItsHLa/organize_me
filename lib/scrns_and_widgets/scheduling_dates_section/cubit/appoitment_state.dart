part of 'appoitment_cubit.dart';

@immutable
sealed class AppoitmentState {
}

final class AppoitmentInitial extends AppoitmentState {}

// for add appoitment
final class AppoitmentAddedSuccsess extends AppoitmentState {}

final class AppoitmentAddedFailed extends AppoitmentState {
  final String msg;

  AppoitmentAddedFailed({required this.msg});
}

// when deleting appoitment
final class AppoitmentDeletedSuccsess extends AppoitmentState {}

final class AppoitmentDeletedFailed extends AppoitmentState {
  final String msg;

  AppoitmentDeletedFailed({required this.msg});
}
