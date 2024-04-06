import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../constants.dart';

part 'appoitment_state.dart';

class AppoitmentCubit extends Cubit<AppoitmentState> {
  AppoitmentCubit() : super(AppoitmentInitial());

  void addAppointment(
    DateTime startTime,
    DateTime endTime,
    String subject,
  ) {
    try {
      Appointment app = Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: subject,
        color: deepPurple,
      );

      // add the scheduled notification
      emit(AppoitmentAddedSuccsess());
    } catch (e) {
      emit(AppoitmentAddedFailed(msg: 'من فضلك أعد إدخال موعدك'));
    }
  }
}
