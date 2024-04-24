part of 'bill_cubit.dart';

@immutable
sealed class BillState {}

final class BillInitial extends BillState {}

final class LoadingBill extends BillState {}

final class BillLoaded extends BillState {
  final String typeOfBill;

  BillLoaded({required this.typeOfBill});
}

final class LoadingBillFailed extends BillState {
  final String msg;

  LoadingBillFailed({required this.msg});
}
