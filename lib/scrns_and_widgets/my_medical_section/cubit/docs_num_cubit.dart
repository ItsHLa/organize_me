import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'docs_num_state.dart';

class DocsNumCubit extends Cubit<DocsNumState> {
  DocsNumCubit() : super(const DocsNumInitial(docsNumber: []));

  void addPhoneNumber(String name, String phoneNumber) {
    try {
      // add
      emit(const AddDocsNumSuccess(docsNumber: []));
    } catch (e) {
      emit(const AddDocsNumFailed('تعذر إدخال جهة الاتصال', docsNumber: []));
    }
  }

  void editPhoneNumber(String name, String phoneNumber) {
    try {
      // add
      emit(const AddDocsNumSuccess(docsNumber: []));
    } catch (e) {
      emit(const AddDocsNumFailed('تعذر إدخال جهة الاتصال', docsNumber: []));
    }
  }

  void deletePhoneNumber(int id) {
    try {
      // add
      emit(const DeleteDocsNumSuccess(docsNumber: []));
    } catch (e) {
      emit(const DeleteDocsNumFailed('تعذر حذف جهة الاتصال', docsNumber: []));
    }
  }
}
