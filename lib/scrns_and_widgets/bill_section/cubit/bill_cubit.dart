import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/electric_bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/telecom_bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/water_bill.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

part 'bill_state.dart';

class BillCubit extends Cubit<BillState> {
  BillCubit() : super(const BillInitial(bills: [], typeOfBill: 'water'));

  void payFromSyriatelCash() async {}

  void loadWater() async {
    List<WaterBill> bills = [];
    await WaterBill.getAllWaBills().then((waBills) => bills = waBills);
    emit(
      LoadingBill(
        bills: bills,
        typeOfBill: 'water',
      ),
    );
    try {
      emit(
        BillLoaded(
          typeOfBill: 'water',
          bills: bills,
        ),
      );
    } catch (e) {
      emit(
        LoadingBillFailed(
          msg: 'حصل خطأ اثناء تحميل فواتيرك',
          bills: bills,
          typeOfBill: 'water',
        ),
      );
    }
  }

  void loadElectric() async {
    List<ElectricBill> bills = [];
    await ElectricBill.getAllElBills().then((elBills) => bills = elBills);
    emit(
      LoadingBill(
        bills: bills,
        typeOfBill: 'electric',
      ),
    );
    try {
      emit(
        BillLoaded(
          typeOfBill: 'electric',
          bills: bills,
        ),
      );
    } catch (e) {
      emit(
        LoadingBillFailed(
          msg: 'حصل خطأ اثناء تحميل فواتيرك',
          typeOfBill: 'electric',
          bills: bills,
        ),
      );
    }
  }

  void loadTelecom() async {
    List<TelecomBill> bills = [];
    await TelecomBill.getAllTelBills().then((telBills) => bills = telBills);
    emit(
      LoadingBill(
        typeOfBill: 'telecom',
        bills: bills,
      ),
    );
    try {
      emit(
        BillLoaded(
          typeOfBill: 'telecom',
          bills: bills,
        ),
      );
    } catch (e) {
      emit(
        LoadingBillFailed(
          msg: 'حصل خطأ اثناء تحميل فواتيرك',
          typeOfBill: 'telecom',
          bills: bills,
        ),
      );
    }
  }
}
