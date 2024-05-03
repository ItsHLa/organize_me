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

  void loadWater() async {
    emit(LoadingBill(bills: bills));
    try {
      await WaterBill.getAllWaBills().then((waBills) => bills = waBills);
      emit(BillLoaded(bills: bills));
    } catch (e) {
      emit(LoadingBill(bills: bills));
    }
  }

  void loadElectric() async {
    emit(LoadingBill(bills: bills));
    try {
      await ElectricBill.getAllElBills().then((elBills) => bills = elBills);
    } catch (e) {
      emit(LoadingBill(bills: bills));
    }
    emit(BillLoaded(bills: bills));
  }

  void loadTelecom() async {
    emit(LoadingBill(bills: bills));
    try {
      await TelecomBill.getAllTelBills().then((telBills) => bills = telBills);
    } catch (e) {
      emit(LoadingBill(bills: bills));
    }
    emit(BillLoaded(bills: bills));
  }
}
