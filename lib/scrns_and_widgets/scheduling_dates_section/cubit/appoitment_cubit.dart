import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../constants.dart';
import '../db/appointment_data_source.dart';

part 'appoitment_state.dart';

class AppoitmentCubit extends Cubit<AppoitmentState> {
  AppoitmentCubit()
      : super(
            AppoitmentInitial(appointmentDataSource: getCalendarDataSource()));

  AppointmentDataSource dataSource = getCalendarDataSource();

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
      dataSource.appointments?.add(app);
      dataSource
          .notifyListeners(CalendarDataSourceAction.add, <Appointment>[app]);
      // add the scheduled notification
      emit(AppoitmentAddedSuccsess(appointmentDataSource: dataSource));
    } catch (e) {
      emit(AppoitmentAddedFailed(
          appointmentDataSource: dataSource, msg: 'من فضلك أعد إدخال موعدك'));
    }
  }

  void deleteAppoitment() {
    try {
      emit(AppoitmentDeletedSuccsess(appointmentDataSource: dataSource));
    } catch (e) {
      emit(AppoitmentDeletedFailed(
          appointmentDataSource: dataSource, msg: 'تعذر حذف رسالتك'));
    }
  }
}
