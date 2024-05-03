part of 'bill_cubit.dart';

@immutable
sealed class BillState {
  final List<Bill> bills;

  const BillState({required this.bills});
}

final class BillInitial extends BillState {
  const BillInitial({required super.bills});
}

final class LoadingBill extends BillState {
  const LoadingBill({required super.bills});
}

final class BillLoaded extends BillState {
  const BillLoaded({required super.bills});
}

final class LoadingBillFailed extends BillState {
  final String msg;

  const LoadingBillFailed(this.msg, {required super.bills});
}
