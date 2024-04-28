part of 'bill_cubit.dart';

@immutable
sealed class BillState {
  final String typeOfBill;
  final List<Bill> bills;

  const BillState({
    required this.bills,
    required this.typeOfBill,
  });
}

final class BillInitial extends BillState {
  const BillInitial({required super.bills, required super.typeOfBill});
}

final class LoadingBill extends BillState {
  const LoadingBill({required super.bills, required super.typeOfBill});
}

final class BillLoaded extends BillState {
  const BillLoaded({required super.typeOfBill, required super.bills});
}

final class LoadingBillFailed extends BillState {
  final String msg;

  const LoadingBillFailed(
      {required this.msg, required super.bills, required super.typeOfBill});
}
