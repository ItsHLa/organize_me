import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'docs_num_state.dart';

class DocsNumCubit extends Cubit<DocsNumState> {
  DocsNumCubit() : super(DocsNumInitial(DocsNumber: const []));

  void addPhoneNumber(String name, String phoneNumber) {
    try {
      // add
      emit(AddDocsNumSuccess(DocsNumber: const []));
    } catch (e) {
      emit(AddDocsNumFailed('تعذر إدخال جهة الاتصال', DocsNumber: const []));
    }
  }

  void editPhoneNumber(String name, String phoneNumber) {
    try {
      // add
      emit(AddDocsNumSuccess(DocsNumber: const []));
    } catch (e) {
      emit(AddDocsNumFailed('تعذر إدخال جهة الاتصال', DocsNumber: const []));
    }
  }

  void deletePhoneNumber(int id) {
    try {
      // add
      emit(DeleteDocsNumSuccess(DocsNumber: const []));
    } catch (e) {
      emit(DeleteDocsNumFailed('تعذر حذف جهة الاتصال', DocsNumber: const []));
    }
  }
}
