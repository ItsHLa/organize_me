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

class ValidateInputData {
  static bool validateField(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  static String? checkIfNull(value) {
    if (value?.isEmpty ?? true) {
      return 'هذا الحقل لا يمكن ان يكون فارغ';
    } else {
      return null;
    }
  }

  static String? checkPhoneNumber(value) {
    if (value?.isEmpty ?? true) {
      return 'هذا الحقل لا يمكن ان يكون فارغ';
    }

    int phoneNumber = int.parse(value!);
    if (phoneNumber.isNegative) {
      return 'هذا الحقل لا يمكن ان يكون يحوي اعداد سالبة';
    }

    if (value!.length < 10) {
      return 'هذا الحقل لا يمكن ان يكون اقل من 10 ارقام';
    }

    if (value!.length > 10) {
      return 'هذا الحقل لا يمكن ان يكون اكبر من 10 ارقام';
    } else {
      return null;
    }
  }

  static String? checkEditedPhoneNumber(value) {
    int phoneNumber = int.parse(value!);
    if (phoneNumber.isNegative) {
      return 'هذا الحقل لا يمكن ان يكون يحوي اعداد سالبة';
    }

    if (value!.length < 10) {
      return 'هذا الحقل لا يمكن ان يكون اقل من 10 ارقام';
    }
  }

  static String? checkInterval(value) {
    if (value?.isEmpty ?? true) {
      return 'هذا الحقل لا يمكن ان يكون فارغ';
    }

    int interval = int.parse(value!);
    if (interval.isNegative) {
      return 'هذا الحقل لا يمكن ان يكون يحوي اعداد سالبة';
    }

    if (value!.length > 10) {
      return 'هذا الحقل لا يمكن ان يكون اكبر من 10 ارقام';
    } else {
      return null;
    }
  }

  static String? checkEditedInterval(value) {
    int interval = int.parse(value!);
    if (interval.isNegative) {
      return 'هذا الحقل لا يمكن ان يكون يحوي اعداد سالبة';
    }

    if (value!.length > 10) {
      return 'هذا الحقل لا يمكن ان يكون اكبر من 10 ارقام';
    } else {
      return null;
    }
  }

  static String? checkStartTime(value) {
    if (value?.isEmpty ?? true) {
      return 'هذا الحقل لا يمكن ان يكون فارغ';
    }

    List<String>? parts = value?.split(':');
    int hour = int.parse(parts![0]);
    int minute = int.parse(parts[1]);
    DateTime currentTime = DateTime.now();
    DateTime scheduledTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, hour, minute);
    Duration difference = scheduledTime.difference(currentTime);
    if (difference.isNegative) {
      return 'لا يمكن ان يكون الوقت المختار اقل من الوقت الحالي';
    } else {
      return null;
    }
  }

  static String? checkEditedStartTime(value) {
    List<String>? parts = value?.split(':');
    int hour = int.parse(parts![0]);
    int minute = int.parse(parts[1]);
    DateTime currentTime = DateTime.now();
    DateTime scheduledTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, hour, minute);
    Duration difference = scheduledTime.difference(currentTime);
    if (difference.isNegative) {
      return 'لا يمكن ان يكون الوقت المختار اقل من الوقت الحالي';
    } else {
      return null;
    }
  }

  static String? checkDateTime(value) {
    if (value?.isEmpty ?? true) {
      return 'هذا الحقل لا يمكن ان يكون فارغ';
    }

    DateTime currentDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    List<String>? parts = value?.split('/');
    int year = int.parse(parts![2]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[0]);
    DateTime date = DateTime(year, month, day);
    if (date.isBefore(currentDate.toUtc())) {
      return 'لا يمكن ان يكون اليوم قبل اليوم الحالي';
    } else {
      return null;
    }
  }

  static String? checkEditedDateTime(value) {
    DateTime currentDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    List<String>? parts = value?.split('/');
    int year = int.parse(parts![2]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[0]);
    DateTime date = DateTime(year, month, day);
    if (date.isBefore(currentDate.toUtc())) {
      return 'لا يمكن ان يكون اليوم قبل اليوم الحالي';
    } else {
      return null;
    }
  }
}