import 'package:flutter/material.dart';

String validateIfTimeBeforeCurrentTime(String? value) {
  if (value?.isEmpty ?? true) {
    return 'هذا الحقل لا يمكن ان يكون فارغ';
  } else {
    return '';
  }
}

Duration differenceBetweenTimes(TimeOfDay timeOfDay) {
  DateTime now = DateTime.now();
  DateTime dateTime =
      DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  Duration duration = dateTime.difference(now);
  return duration;
}

Duration timeOfDayToDuration(TimeOfDay timeOfDay) {
  // Create a DateTime object with today's date and the time from TimeOfDay
  DateTime now = DateTime.now();
  DateTime dateTime =
      DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

  // Calculate the difference between now and the specified time
  Duration duration = dateTime.difference(now);

  // Handle the case when the specified time is before the current time
  if (duration.isNegative) {
    // Add a day to make the duration positive
    duration += const Duration(days: 1);
  }

  return duration;
}

bool validateField(GlobalKey<FormState> formKey) {
  if (formKey.currentState!.validate()) {
    return true;
  } else {
    return false;
  }
}
