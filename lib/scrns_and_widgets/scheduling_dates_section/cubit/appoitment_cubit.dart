import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'appoitment_state.dart';

class AppoitmentCubit extends Cubit<AppoitmentState> {
  AppoitmentCubit() : super(AppoitmentInitial());

  void addAppointment(
    DateTime startTime,
    DateTime endTime,
    String subject,
  ) {
    try {
      // add the scheduled notification
      emit(AppoitmentAddedSuccsess());
    } catch (e) {
      emit(AppoitmentAddedFailed(msg: 'من فضلك أعد إدخال موعدك'));
    }
  }
}
