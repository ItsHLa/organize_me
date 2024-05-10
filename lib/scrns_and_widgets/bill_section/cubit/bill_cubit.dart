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

  Future<void> monthlySpendingOneCategory(
    int year,
    int month,
  ) async {
    emit(const MonthlySpendingLoading(bills: []));
    try {
      List tableName = [
        WaterBill.tableName,
        ElectricBill.tableName,
        TelecomBill.tableName,
      ];
      List categorySum = [];
      double sumMonthlySpending = 0;
      for (var table in tableName) {
        print(table);
        double sum = await Bill.calculatePayments(table, year, month);
        categorySum.add(sum);
        sumMonthlySpending += sum;
      }
      emit(MonthlySpendingCalculated(
          bills: bills,
          monthlySpendingWater: (categorySum[0] / sumMonthlySpending) * 360,
          monthlySpendingElectricity:
              (categorySum[1] / sumMonthlySpending) * 360,
          monthlySpendingTelecom: (categorySum[2] / sumMonthlySpending) * 360,
          monthlySpendingAll: sumMonthlySpending));
    } catch (e) {
      print('ff');
      emit(const MonthlySpendingFailed(bills: []));
    }
  }
}
