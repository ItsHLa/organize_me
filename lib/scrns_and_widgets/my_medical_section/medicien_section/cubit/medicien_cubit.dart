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
      String shotTime = '${timeOfshot.hour} : ${timeOfshot.minute}';
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
    required String editedname,
    required TimeOfDay editedtimeOfshot,
    required int editedinterval,
  }) {
    try {
      String shotTime = '${editedtimeOfshot.hour} : ${editedtimeOfshot.minute}';
      // editing info .......
      //////
      MedicienNotification.showMedicienNotification(
          id: 1,
          medName: editedname,
          timeOfDose: editedtimeOfshot,
          hoursBetweenShots: editedinterval);
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
      // pass the id of med
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
