import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/models/med.dart';
import 'package:organize_me/services/work_manager_service.dart';
import 'package:workmanager/workmanager.dart';

import '../../../../services/functionality.dart';

part 'medicien_state.dart';

class MedicineCubit extends Cubit<MedicineState> {
  List<Med> meds = [];
  int id = 0;

  MedicineCubit() : super(const MedInitial(meds: []));

  void addMed(
    String name,
    TimeOfDay timeOfShot,
    int interval,
  ) async {
    try {
      String shotTime = '${timeOfShot.hour} : ${timeOfShot.minute}';
      await Med.addMed(name, shotTime, interval).then((med) => meds.add(med));
      debugPrint(timeOfDayToDuration(timeOfShot).toString());
      WorkManagerService.registerMyTask(
        uniqueTaskName: 'medicine $id notification',
        taskName: 'show medicine notification',
        frequency: Duration(hours: interval),
        title: name,
        id: id,
        initialDelay: timeOfDayToDuration(timeOfShot),
      );
      id++;

      emit(AddMedSuccses(meds: meds));
    } catch (e) {
      emit(AddMedsFailed(meds: meds));
    }
  }

  void editMed({
    required int id,
    required String editedName,
    required TimeOfDay editedTimeOfShot,
    required int editedInterval,
  }) {
    try {
      // String shotTime = '${editedTimeOfShot.hour} : ${editedTimeOfShot.minute}';
      WorkManagerService.registerMyTask(
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

