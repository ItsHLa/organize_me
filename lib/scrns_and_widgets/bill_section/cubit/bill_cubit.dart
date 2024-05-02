import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/electric_bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/telecom_bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/water_bill.dart';

part 'bill_state.dart';

class BillCubit extends Cubit<BillState> {
  BillCubit() : super(const BillInitial(bills: [], typeOfBill: 'water'));

  void payFromSyriatelCash() async {}

  void loadBills(String typeOfBill) async {
    dynamic bill;
    emit(LoadingBill(bills: const [], typeOfBill: typeOfBill));
    try {
      switch (typeOfBill) {
        case 'water':
          bill = await loadWater();
        case 'electric':
          bill = await loadElectric();
        case 'telecom':
          bill = await loadTelecom();
      }
      emit(BillLoaded(typeOfBill: typeOfBill, bills: bill));
    } catch (e) {
      emit(LoadingBill(bills: const [], typeOfBill: typeOfBill));
    }
  }

  Future<List<WaterBill>> loadWater() async {
    List<WaterBill> bills = [];
    await WaterBill.getAllWaBills().then((waBills) => bills = waBills);
    return bills;
  }

  Future<List<ElectricBill>> loadElectric() async {
    List<ElectricBill> bills = [];
    await ElectricBill.getAllElBills().then((elBills) => bills = elBills);
    return bills;
  }

  Future<List<TelecomBill>> loadTelecom() async {
    List<TelecomBill> bills = [];
    await TelecomBill.getAllTelBills().then((telBills) => bills = telBills);
    return bills;
  }
}
