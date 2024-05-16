import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/electric_bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/telecom_bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/water_bill.dart';

import '../models/bill.dart';

part 'bill_state.dart';

class BillCubit extends Cubit<BillState> {
  List<Bill> bills = [];

  BillCubit() : super(const BillInitial(bills: []));

  void payFromSyriatelCash() async {}

  Future<void> loadWater() async {
    emit(LoadingBill(bills: bills));
    try {
      await WaterBill.getAllBills().then((waBills) => bills = waBills);
      emit(WaterLoaded(bills: bills));
    } catch (e) {
      emit(WaterFailed(e.toString(), bills: bills));
    }
  }

  Future<void> loadElectric() async {
    emit(LoadingBill(bills: bills));
    try {
      await ElectricBill.getAllBills().then((elBills) => bills = elBills);
      emit(ElectricLoaded(bills: bills));
    } catch (e) {
      emit(ElectricFailed(e.toString(), bills: bills));
    }
  }

  Future<void> loadTelecom() async {
    emit(LoadingBill(bills: bills));
    try {
      await TelecomBill.getAllBills().then((telBills) => bills = telBills);
      emit(TelecomLoaded(bills: bills));
    } catch (e) {
      emit(TelecomFailed(e.toString(), bills: bills));
    }
  }

  Future<void> monthlySpendingOneCategory(String year,
      String month,) async {
    emit(MonthlySpendingLoading(bills: bills));
    try {
      List<double> percent = [0, 0, 0];
      List<double> sum = [0, 0, 0];

      Future<double>.value(
          await Bill.calculatePayments(ElectricBill.tableName, year, month)
              .then((value) => sum[0] = value));
      Future<double>.value(
          await Bill.calculatePayments(TelecomBill.tableName, year, month)
              .then((value) => sum[1] = value));
      Future<double>.value(
          await Bill.calculatePayments(WaterBill.tableName, year, month)
              .then((value) => sum[2] = value));
      double sumMonthlySpending = sum[0] + sum[1] + sum[2];
      percent[0] = ((sum[0] / sumMonthlySpending) * 100).roundToDouble();
      percent[1] = ((sum[1] / sumMonthlySpending) * 100).roundToDouble();
      percent[2] = ((sum[2] / sumMonthlySpending) * 100).roundToDouble();
      print(percent);
      emit(MonthlySpendingCalculated(
          bills: bills,
          monthlySpendingAll: sumMonthlySpending,
          percent: percent,
          sum: sum));
    } catch (e) {
      emit(MonthlySpendingFailed(bills: bills));
    }
  }
}
