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
    String year,
    String month,
  ) async {
    emit(MonthlySpendingLoading(bills: bills));
    try {
      double telecom = 0;
      double water = 0;
      double electric = 0;
      await Bill.calculatePayments(TelecomBill.tableName, year, month)
          .then((value) => telecom = value);
      print('telecom $telecom');
      await Bill.calculatePayments(WaterBill.tableName, year, month)
          .then((value) => water = value);
      print('water $water');
      await Bill.calculatePayments(ElectricBill.tableName, year, month)
          .then((value) => electric = value);
      print('telecom $electric');
      double sumMonthlySpending = water + electric + telecom;
      emit(MonthlySpendingCalculated(
          bills: bills,
          monthlySpendingWater: water,
          monthlySpendingElectricity: electric,
          monthlySpendingTelecom: telecom,
          monthlySpendingAll: sumMonthlySpending));
    } catch (e) {
      emit(MonthlySpendingFailed(bills: bills));
    }
  }
}
