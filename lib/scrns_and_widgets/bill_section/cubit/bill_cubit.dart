import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bill_state.dart';

class BillCubit extends Cubit<BillState> {
  BillCubit() : super(BillInitial());

  void loadWater() {
    emit(LoadingBill());
    try {
      emit(BillLoaded());
    } catch (e) {
      emit(LoadingBillFailed('حصل خطأ اثناء تحميل فواتيرك'));
    }
  }
}
