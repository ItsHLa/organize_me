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
      emit(BillLoaded(bills: bills));
    } catch (e) {
      emit(LoadingBillFailed(e.toString(), bills: bills));
    }
  }

  Future<void> loadElectric() async {
    emit(LoadingBill(bills: bills));
    try {
      await ElectricBill.getAllBills().then((elBills) => bills = elBills);
      emit(BillLoaded(bills: bills));
    } catch (e) {
      emit(LoadingBillFailed(e.toString(), bills: bills));
    }
  }

  Future<void> loadTelecom() async {
    emit(LoadingBill(bills: bills));
    try {
      await TelecomBill.getAllBills().then((telBills) => bills = telBills);
      emit(BillLoaded(bills: bills));
    } catch (e) {
      emit(LoadingBillFailed(e.toString(), bills: bills));
    }
  }
}
