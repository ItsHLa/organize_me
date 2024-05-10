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

final class MonthlySpendingLoading extends BillState {
  const MonthlySpendingLoading({required super.bills});
}

final class LoadingElectric extends BillState {
  const LoadingElectric({required super.bills});
}

final class ElectricLoaded extends BillState {
  const ElectricLoaded({required super.bills});
}

final class ElectricFailed extends BillState {
  final String msg;

  const ElectricFailed(this.msg, {required super.bills});
}

final class LoadingWater extends BillState {
  const LoadingWater({required super.bills});
}

final class WaterLoaded extends BillState {
  const WaterLoaded({required super.bills});
}

final class WaterFailed extends BillState {
  final String msg;

  const WaterFailed(this.msg, {required super.bills});
}

final class LoadingTelecom extends BillState {
  const LoadingTelecom({required super.bills});
}

final class TelecomLoaded extends BillState {
  const TelecomLoaded({required super.bills});
}

final class TelecomFailed extends BillState {
  final String msg;

  const TelecomFailed(this.msg, {required super.bills});
}

final class MonthlySpendingCalculated extends BillState {
  final double monthlySpendingWater;
  final double monthlySpendingElectricity;
  final double monthlySpendingTelecom;
  final double monthlySpendingAll;

  const MonthlySpendingCalculated(
      {required super.bills,
      required this.monthlySpendingWater,
      required this.monthlySpendingElectricity,
      required this.monthlySpendingTelecom,
      required this.monthlySpendingAll});
}

final class MonthlySpendingFailed extends BillState {
  const MonthlySpendingFailed({required super.bills});
}