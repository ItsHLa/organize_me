import 'package:flutter/cupertino.dart';

String validateIfTimeBeforeCurrentTime(String? value) {
  if (value?.isEmpty ?? true) {
    return 'هذا الحقل لا يمكن ان يكون فارغ';
  } else {
    return '';
  }
}

bool validateField(GlobalKey<FormState> formKey) {
  if (formKey.currentState!.validate()) {
    return true;
  } else {
    return false;
  }
}
