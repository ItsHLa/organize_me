import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/models/med.dart';
import 'package:organize_me/services/work_manager_service.dart';
import 'package:workmanager/workmanager.dart';

import '../../../../services/functionality.dart';

part 'medicien_state.dart';

class MedicineCubit extends Cubit<MedicineState> {
  List<Med> meds = [];

  MedicineCubit() : super(const MedInitial(meds: []));

  void addMed(
    String name,
    TimeOfDay timeOfShot,
    int interval,
  ) async {
    try {
      String shotTime = '${timeOfShot.hour} : ${timeOfShot.minute}';
      Map med = await Med.addMed(name, shotTime, interval);
      meds.add(Med.fromMap(med));
      debugPrint(timeOfDayToDuration(timeOfShot).toString());
      WorkManagerService.registerNotificationTask(
        uniqueTaskName: 'medicine ${med['id']} notification',
        taskName: 'show medicine notification',
        frequency: Duration(hours: interval),
        title: name,
        id: med['id'],
        initialDelay: timeOfDayToDuration(timeOfShot),
      );
      emit(AddMedSuccses(meds: meds));
    } catch (e) {
      emit(AddMedsFailed(meds: meds));
    }
  }

  Future<void> editMed({
    required int id,
    required String editedName,
    required TimeOfDay editedTimeOfShot,
    required int editedInterval,
  }) async {
    try {
      String shotTime = '${editedTimeOfShot.hour} : ${editedTimeOfShot.minute}';
      Map newMedMap = await Med.editMed(id,
          newInterval: editedInterval,
          newName: editedName,
          newShotTime: shotTime);
      int i = meds.indexOf(meds.singleWhere((med) => med.id == id));
      Med newTask = Med.fromMap(newMedMap);
      meds[i] = newTask;
      WorkManagerService.registerNotificationTask(
          uniqueTaskName: 'medicine $id notification',
          taskName: 'show medicine notification',
          frequency: Duration(hours: editedInterval),
          title: editedName,
          id: id,
          initialDelay: timeOfDayToDuration(editedTimeOfShot),
          existingWorkPolicy: ExistingWorkPolicy.update);
      emit(AddMedSuccses(meds: meds));
    } catch (e) {
      emit(AddMedsFailed(meds: meds));
    }
  }

  void deleteMed(int medId) async {
    try {
      await Med.deleteMed(medId).then(
        (_) => meds.remove(
          meds.singleWhere((med) => med.id == medId),
        ),
      );
      WorkManagerService.cancelTask('medicine $medId notification ');
      emit(DeleteMedsSuccses(meds: meds));
    } catch (e) {
      emit(DeleteMedsFailed(meds: meds));
    }
  }

  void loadMedsData() async {
    emit(LoadMeds(meds: meds));
    try {
      await Med.getAllMeds().then(
        (value) {
          meds = value;
        },
      );
      emit(MedsLoaded(meds: meds));
    } catch (e) {
      emit(MedsLoaded(meds: meds));
    }
  }
}

