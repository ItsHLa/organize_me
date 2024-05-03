import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/electric_bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/telecom_bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/water_bill.dart';

import '../models/bill.dart';
part 'bill_state.dart';

class BillCubit extends Cubit<BillState> {
  BillCubit() : super(BillInitial(bill: const []));

  void payFromSyriatelCash() async {}
  List<Bill> bill = [];

  void loadWater() async {
    emit(LoadingBill(bill: const []));
    try {
      await WaterBill.getAllWaBills().then((waBills) => bill = waBills);
      emit(BillLoaded(bill: bill));
    } catch (e) {
      emit(LoadingBill(bill: const []));
    }
  }

  void loadElectric() async {
    await ElectricBill.getAllElBills().then((elBills) => bill = elBills);
    print(bill);
    emit(BillLoaded(bill: bill));
  }

  void loadTelecom() async {
    print(bill);
    await TelecomBill.getAllTelBills().then((telBills) => bill = telBills);
    emit(BillLoaded(bill: bill));
  }
}
