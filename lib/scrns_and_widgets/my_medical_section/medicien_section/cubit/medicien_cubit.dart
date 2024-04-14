import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'medicien_state.dart';

class MedicienCubit extends Cubit<MedicienState> {
  MedicienCubit() : super(MedInitial(Meds: []));

  void addMed() {
    try {
      //add to db
      //MedicienNotification.showMedicienNotification(
      // med: med, pass the object
      // dateOfDose: dateOfDose,
      // timeOfDose: timeOfDose);
      emit(AddMedSuccses(Meds: []));
    } catch (e) {
      emit(AddMedsFailed(Meds: []));
    }
  }

  void editMed() {
    try {
      emit(AddMedSuccses(Meds: []));
    } catch (e) {
      emit(AddMedsFailed(Meds: []));
    }
  }

  void deleteMed() {
    try {
      //MedicienNotification.cancelMedicienNotification(id);
      // pass the id of med
      emit(DeleteMedsSuccses(Meds: []));
    } catch (e) {
      emit(DeleteMedsFailed(Meds: []));
    }
  }

  void loadMedsData() {
    emit(LoadMeds(Meds: []));
    try {
      emit(MedsLoaded(Meds: []));
    } catch (e) {
      emit(MedsLoaded(Meds: []));
    }
  }
}
