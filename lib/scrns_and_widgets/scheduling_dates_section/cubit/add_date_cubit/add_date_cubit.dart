import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_date_state.dart';

class AddDateCubit extends Cubit<AddDateState> {
  AddDateCubit() : super(DateInitial());

  void addDate(DateTime start, DateTime end, String name,
      EventController monthController) {
    emit(AddDateLoading());
    try {
      final event = CalendarEventData(
        date: start,
        endDate: end,
        title: name,
      );
      monthController.add(event);
      // add the scheduled notification
      emit(AddDateSucsses());
    } catch (e) {
      emit(AddDateFaild(msg: 'من فضلك أعد إدخال موعدك'));
    }
  }
}
