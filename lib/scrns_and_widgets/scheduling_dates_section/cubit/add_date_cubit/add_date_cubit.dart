import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';

part 'add_date_state.dart';

class TaskCubit extends Cubit<DateState> {
  TaskCubit() : super(DateInitial());

  void addDate(
      DateTime start, DateTime end, String name, BuildContext context) {
    emit(AddDateLoading());
    try {
      final event = CalendarEventData(
        date: start,
        endDate: end,
        title: name,
      );
      CalendarControllerProvider.of(context).controller.add(event);
      // add the scheduled notification
      emit(AddDateSucsses());
    } catch (e) {
      emit(AddDateFaild(msg: 'من فضلك أعد إدخال موعدك'));
    }
  }
}
