import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'docs_num_state.dart';

class DocsNumCubit extends Cubit<DocsNumState> {
  DocsNumCubit() : super(DocsNumInitial(DocsNumber: []));

  void addPhoneNumber(String name, String phoneNumber) {
    try {
      // add
      emit(AddDocsNumSuccess(DocsNumber: []));
    } catch (e) {
      emit(AddDocsNumFailed('تعذر إدخال رقم الهاتف', DocsNumber: []));
    }
  }

  void deletePhoneNumber(int id) {
    try {
      // add
      emit(DeleteDocsNumSuccess(DocsNumber: []));
    } catch (e) {
      emit(DeleteDocsNumFailed('تعذر حذف رقم الهاتف', DocsNumber: []));
    }
  }
}
