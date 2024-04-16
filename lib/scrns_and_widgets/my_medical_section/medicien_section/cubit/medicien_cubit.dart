import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/models/med.dart';

import '../../../../services/local_notification_service/medicien_notification.dart';

part 'medicien_state.dart';

class MedicienCubit extends Cubit<MedicienState> {
  List<Med> meds = [];

  MedicienCubit() : super(const MedInitial(meds: []));

  void addMed(
    String name,
    TimeOfDay timeOfshot,
    int interval,
  ) async {
    try {
      String shotTime = '${timeOfshot.hour}:${timeOfshot.minute}';
      await Med.addMed(name, shotTime, interval).then((med) => meds.add(med));
      MedicienNotification.showMedicienNotification(
          id: 1,
          hoursBetweenShots: interval,
          medName: name,
          timeOfDose: timeOfshot);
      emit(AddMedSuccses(meds: meds));
    } catch (e) {
      emit(AddMedsFailed(meds: meds));
    }
  }

  void editMed({
    required int medId,
    required String editedName,
    required TimeOfDay? editedShotTime,
    required int editedInterval,
  }) async {
    try {
      String shotTime = editedShotTime != null
          ? '${editedShotTime.hour}:${editedShotTime.minute}'
          : '';
      Med newMed = await Med.editMed(
        medId,
        newInterval: editedInterval,
        newName: editedName,
        newShotTime: shotTime,
      );
      int i = meds.indexOf(meds.singleWhere((med) => med.id == medId));
      meds[i] = newMed;
      List<String> shotTimeList = newMed.shotTime.split(':');
      MedicienNotification.showMedicienNotification(
        id: 1,
        medName: newMed.name,
        timeOfDose: TimeOfDay(
            hour: int.parse(shotTimeList[0]),
            minute: int.parse(shotTimeList[1])),
        hoursBetweenShots: editedInterval,
      );
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
      MedicienNotification.cancelMedicienNotification(medId);
      emit(DeleteMedsSuccses(meds: meds));
    } catch (e) {
      emit(DeleteMedsFailed(meds: meds));
    }
  }

  void loadMedsData() async {
    emit(LoadMeds(meds: meds));
    try {
      await Med.getAllMeds().then(
        (meds) {
          emit(MedsLoaded(meds: meds));
        },
      );
    } catch (e) {
      emit(MedsLoaded(meds: meds));
    }
  }
}
