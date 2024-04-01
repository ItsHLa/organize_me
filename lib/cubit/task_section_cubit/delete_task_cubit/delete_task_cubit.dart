import 'package:bloc/bloc.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'delete_task_state.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskState> {
  DeleteTaskCubit() : super(DeleteTaskInitial());


  void deleteTask ( BuildContext context ,CalendarEventData<Object?> event){
    emit(DeleteTaskLoading());
    try{
      CalendarControllerProvider.of(context).controller.remove(event);
      // cancel the scheduled notification
    }catch(e){
      emit(DeleteTaskFaild(msg: 'يرجى إعادة المحاولة'));
      
    }
  }


}
