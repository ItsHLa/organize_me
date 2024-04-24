import 'package:flutter/cupertino.dart';

class ValidateInput {
  static String validateIntrval(String? value) {
    int x = int.parse(value!);
    if (x.isNegative) {
      return 'هذا الحقل لا يمكن ان يكون يحوي اعداد سالبة';
    } else {
      return '';
    }
  }

  static String validateIfTimeBeforeCurrentTime(String? value) {
    if (value?.isEmpty ?? true) {
      return 'هذا الحقل لا يمكن ان يكون فارغ';
    } else {
      return '';
    }
  }

  static bool validateField(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
