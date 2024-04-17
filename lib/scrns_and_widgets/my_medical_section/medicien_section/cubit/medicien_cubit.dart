import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/models/med.dart';
import 'package:organize_me/services/local_notification_service/medicien_notification.dart';

import '../../../../services/work_manager_service/medicien_work_manager.dart';

part 'medicien_state.dart';

class MedicienCubit extends Cubit<MedicienState> {
  List<Med> meds = [];

  MedicienCubit() : super(const MedInitial(meds: []));

  void addMed(
    String name,
    TimeOfDay timeOfshot,
    int interval,) async {
    try {
      String shotTime = '${timeOfshot.hour} : ${timeOfshot.minute}';
      await Med.addMed(name, shotTime, interval).then((med) => meds.add(med));

      MedicineAlarm.showMedicineNotificationInterval(
          interval: Duration(minutes: interval),
          id: 10,
          name: name,
          callback: callback,
          startTime: timeOfshot);

      emit(AddMedSuccses(meds: meds));
    } catch (e) {
      emit(AddMedsFailed(meds: meds));
    }
  }

  void editMed({
    required int id,
    required String editedname,
    required TimeOfDay editedtimeOfshot,
    required int editedinterval,
  }) {
    try {
      String shotTime = '${editedtimeOfshot.hour} : ${editedtimeOfshot.minute}';
      // editing info .......
      //////

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
      // MedicienNotification.cancelMedicienNotification(medId);
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

@pragma('vm:entry-point')
void callback(int id) async {
  MedicienNotification.showSimpleNotification(id: id);
  debugPrint('alarm on ${TimeOfDay.now()}');
}
