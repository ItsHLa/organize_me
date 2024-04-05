import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'add_date_state.dart';

class AddAppointmentCubit extends Cubit<AddAppointmentState> {
  AddAppointmentCubit() : super(AddAppointmentInitial());

  List<Appointment> appointments = <Appointment>[
    Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(Duration(hours: 2)),
      subject: 'Meeting with Client',
      color: deepPurple,
    )
  ];

  void addAppointment(DateTime startTime,
      DateTime endTime,
      String subject,) {
    emit(AddAppointmentLoading());
    try {
      appointments.add(Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: subject,
        color: deepPurple,
      ));
      log('${appointments}');
      // add the scheduled notification
      emit(AddAppointmentSucsses());
    } catch (e) {
      emit(AddAppointmentFailed());
    }
  }
}
