import 'package:bloc/bloc.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

part 'add_task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  void addTask (DateTime start , DateTime end , String name , BuildContext context){
    emit(AddTaskLoading());
    try{
      final event = CalendarEventData(
        date: start,
        endDate: end,
        title: name ,
      );
      CalendarControllerProvider.of(context).controller.add(event);
      // add the scheduled notification
      emit(AddTaskSucsses());
    }catch(e){
      emit(AddTaskFaild(msg:'من فضلك أعد إدخال المهمة'));
    }


  }

}
