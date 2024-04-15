import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/models/med.dart';

part 'medicien_state.dart';

class MedicienCubit extends Cubit<MedicienState> {
  List<Med> meds = [];
  MedicienCubit() : super(const MedInitial(meds: []));

  void addMed(
    String name,
    String shotTime,
    int interval,
  ) async {
    try {
      await Med.addMed(name, shotTime, interval).then((med) => meds.add(med));
      //MedicienNotification.showMedicienNotification(
      // med: med, pass the object
      // dateOfDose: dateOfDose,
      // timeOfDose: timeOfDose);
      emit(AddMedSuccses(meds: meds));
    } catch (e) {
      emit(AddMedsFailed(meds: meds));
    }
  }

  void editMed() {
    try {
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
      //MedicienNotification.cancelMedicienNotification(id);
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
