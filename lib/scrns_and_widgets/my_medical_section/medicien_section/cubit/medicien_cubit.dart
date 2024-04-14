import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'medicien_state.dart';

class MedicienCubit extends Cubit<MedicienState> {
  MedicienCubit() : super(const MedInitial(meds: []));

  void addMed() {
    try {
      //add to db
      //MedicienNotification.showMedicienNotification(
      // med: med,
      // dateOfDose: dateOfDose,
      // timeOfDose: timeOfDose);
      emit(const AddMedSuccses(meds: []));
    } catch (e) {
      emit(const AddMedsFailed(meds: []));
    }
  }

  void deleteMed() {
    try {
      //MedicienNotification.cancelMedicienNotification(id);
      // pass the id of med
      emit(const DeleteMedsSuccses(meds: []));
    } catch (e) {
      emit(const DeleteMedsFailed(meds: []));
    }
  }

  void loadMedsData() {
    emit(const LoadMeds(meds: []));
    try {
      emit(const MedsLoaded(meds: []));
    } catch (e) {
      emit(const MedsLoaded(meds: []));
    }
  }
}
