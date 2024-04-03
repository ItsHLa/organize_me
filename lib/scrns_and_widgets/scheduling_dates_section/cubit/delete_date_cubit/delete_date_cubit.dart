import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';

part 'delete_date_state.dart';

class DeleteDateCubit extends Cubit<DeleteDateState> {
  DeleteDateCubit() : super(DeleteDateInitial());

  void deleteDate(BuildContext context, CalendarEventData<Object?> event) {
    emit(DeleteDateLoading());
    try {
      CalendarControllerProvider.of(context).controller.remove(event);
      // cancel the scheduled notification
    } catch (e) {
      emit(DeleteDateFaild(msg: 'يرجى إعادة المحاولة'));
    }
  }
}
