import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../constants.dart';

part 'appoitment_state.dart';

class AppoitmentCubit extends Cubit<AppoitmentState> {
  AppoitmentCubit() : super(AppoitmentInitial());

  List<Appointment> appointments = <Appointment>[];

  void addAppointment(
    DateTime startTime,
    DateTime endTime,
    String subject,
  ) {
    try {
      appointments.add(Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: subject,
        color: deepPurple,
      ));
      log('${appointments}');
      // add the scheduled notification
      emit(AppoitmentAddedSuccsess());
      emit(AppoitmentUpdated(appointments: appointments));
    } catch (e) {
      emit(AppoitmentAddedFailed(msg: 'من فضلك أعد إدخال موعدك'));
    }
  }
}
