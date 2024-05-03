part of 'bill_cubit.dart';

@immutable
sealed class BillState {
  List bill;

  BillState({required this.bill});
}

final class BillInitial extends BillState {
  BillInitial({required super.bill});
}

final class LoadingBill extends BillState {
  LoadingBill({required super.bill});
}

final class BillLoaded extends BillState {
  BillLoaded({required super.bill});
}

final class LoadingBillFailed extends BillState {
  final String msg;

  LoadingBillFailed(this.msg, {required super.bill});
}
