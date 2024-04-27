part of 'bill_cubit.dart';

@immutable
sealed class BillState {
  final String typeOfBill;
  final List bills;

  BillState({
    required this.bills,
    required this.typeOfBill,
  });
}

final class BillInitial extends BillState {
  BillInitial({required super.bills, required super.typeOfBill});
}

final class LoadingBill extends BillState {
  LoadingBill({required super.bills, required super.typeOfBill});
}

final class BillLoaded extends BillState {
  BillLoaded({required super.typeOfBill, required super.bills});
}

final class LoadingBillFailed extends BillState {
  final String msg;

  LoadingBillFailed(
      {required this.msg, required super.bills, required super.typeOfBill});
}
