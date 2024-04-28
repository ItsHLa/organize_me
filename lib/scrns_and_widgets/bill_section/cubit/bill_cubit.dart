import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bill_state.dart';

class BillCubit extends Cubit<BillState> {
  BillCubit() : super(BillInitial(bills: [], typeOfBill: 'water'));

  void loadWater() {
    emit(LoadingBill(bills: [], typeOfBill: 'water'));
    try {
      emit(BillLoaded(typeOfBill: 'water', bills: []));
    } catch (e) {
      emit(LoadingBillFailed(
          msg: 'حصل خطأ اثناء تحميل فواتيرك', bills: [], typeOfBill: 'water'));
    }
  }

  void loadElectric() {
    emit(LoadingBill(bills: [], typeOfBill: 'electric'));
    try {
      emit(BillLoaded(typeOfBill: 'electric', bills: []));
    } catch (e) {
      emit(LoadingBillFailed(
          msg: 'حصل خطأ اثناء تحميل فواتيرك',
          typeOfBill: 'electric',
          bills: []));
    }
  }

  void loadTelecom() {
    emit(LoadingBill(typeOfBill: 'telecom', bills: []));
    try {
      emit(BillLoaded(typeOfBill: 'telecom', bills: []));
    } catch (e) {
      emit(LoadingBillFailed(
          msg: 'حصل خطأ اثناء تحميل فواتيرك',
          typeOfBill: 'telecom',
          bills: []));
    }
  }
}
