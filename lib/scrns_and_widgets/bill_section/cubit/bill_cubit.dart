import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bill_state.dart';

class BillCubit extends Cubit<BillState> {
  BillCubit() : super(BillInitial());

  void loadWater() {
    emit(LoadingBill());
    try {
      emit(BillLoaded(typeOfBill: 'water'));
    } catch (e) {
      emit(LoadingBillFailed(msg: 'حصل خطأ اثناء تحميل فواتيرك'));
    }
  }

  void loadElectric() {
    emit(LoadingBill());
    try {
      emit(BillLoaded(typeOfBill: 'electric'));
    } catch (e) {
      emit(LoadingBillFailed(msg: 'حصل خطأ اثناء تحميل فواتيرك'));
    }
  }

  void loadTelecom() {
    emit(LoadingBill());
    try {
      emit(BillLoaded(typeOfBill: 'telecom'));
    } catch (e) {
      emit(LoadingBillFailed(msg: 'حصل خطأ اثناء تحميل فواتيرك'));
    }
  }
}
