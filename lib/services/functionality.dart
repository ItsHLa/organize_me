import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

String validateIfTimeBeforeCurrentTime(String? value) {
  if (value?.isEmpty ?? true) {
    return 'هذا الحقل لا يمكن ان يكون فارغ';
  } else {
    return '';
  }
}

List getPages(bool taskNotes, bool bills, bool medsAndDocs) {
  List pages = [];
  if (taskNotes) {
    pages.add(taskPage);
    pages.add(notesPage);
  }

  if (bills) {
    pages.add(billsPage);
  }

  if (medsAndDocs) {
    pages.add(docsNumPage);
    pages.add(medsPage);
  }

  return pages;
}

List<TabItem> getTabs(bool taskNotes, bool bills, bool medsAndDocs) {
  List<TabItem> tabs = [];
  if (taskNotes) {
    tabs.add(taskTab);
    tabs.add(notesTab);
  }

  if (bills) {
    tabs.add(billsTab);
  }

  if (medsAndDocs) {
    tabs.add(docsNumTab);
    tabs.add(medsTab);
  }

  return tabs;
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

  static String? checkIfNull(String? value) {
    if (value?.isEmpty ?? true) {
      return 'هذا الحقل لا يمكن ان يكون فارغ';
    } else {
      return null;
    }
  }

  static String? checkPhoneNumber(String? value) {
    if (value?.isEmpty ?? true) {
      return 'هذا الحقل لا يمكن ان يكون فارغ';
    }
    int phoneNumber = int.parse(value!);
    if (phoneNumber.isNegative) {
      return 'هذا الحقل لا يمكن ان يكون يحوي اعداد سالبة';
    } else if (value.length < 10) {
      return 'هذا الحقل لا يمكن ان يكون اقل من 10 ارقام';
    } else if (value.length > 10) {
      return 'هذا الحقل لا يمكن ان يكون اكبر من 10 ارقام';
    } else {
      return null;
    }
  }

  static String? checkEditedPhoneNumber(String? value) {
    int phoneNumber = int.parse(value!);
    if (phoneNumber.isNegative) {
      return 'هذا الحقل لا يمكن ان يكون يحوي اعداد سالبة';
    } else if (value.length < 10) {
      return 'هذا الحقل لا يمكن ان يكون أقل من 10 ارقام';
    } else {
      return null;
    }
  }

  static String? checkInterval(String? value) {
    if (value?.isEmpty ?? true) {
      return 'هذا الحقل لا يمكن ان يكون فارغ';
    }
    int interval = int.parse(value!);
    if (interval.isNegative) {
      return 'هذا الحقل لا يمكن أن يحوي أعداد سالبة';
    } else if (value.length > 10) {
      return 'هذا الحقل لا يمكن أن يكون أكبر من 10 أرقام';
    } else {
      return null;
    }
  }

  static String? checkEditedInterval(String? value) {
    int interval = int.parse(value!);
    if (interval.isNegative) {
      return 'هذا الحقل لا يمكن ان يكون يحوي اعداد سالبة';
    } else if (value.length > 10) {
      return 'هذا الحقل لا يمكن ان يكون اكبر من 10 ارقام';
    } else {
      return null;
    }
  }

  static String? checkStartTime(String? value) {
    if (value?.isEmpty ?? true) {
      return 'هذا الحقل لا يمكن ان يكون فارغ';
    }
    List<String>? parts = value?.split(':');
    int hour = int.parse(parts![0]);
    int minute = int.parse(parts[1]);
    DateTime currentTime = DateTime.now();
    DateTime scheduledTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      hour,
      minute,
    );
    Duration difference = scheduledTime.difference(currentTime);
    if (difference.isNegative) {
      return 'لا يمكن ان يكون الوقت المختار اقل من الوقت الحالي';
    } else {
      return null;
    }
  }

  static String? checkEditedStartTime(String? value) {
    List<String>? parts = value?.split(':');
    int hour = int.parse(parts![0]);
    int minute = int.parse(parts[1]);
    DateTime currentTime = DateTime.now();
    DateTime scheduledTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      hour,
      minute,
    );
    Duration difference = scheduledTime.difference(currentTime);
    if (difference.isNegative) {
      return 'لا يمكن ان يكون الوقت المختار اقل من الوقت الحالي';
    } else {
      return null;
    }
  }

  static String? checkDateTime(String? value) {
    if (value?.isEmpty ?? true) {
      return 'هذا الحقل لا يمكن ان يكون فارغ';
    }
    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(
      now.year,
      now.month,
      now.day,
    );
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

  static String? checkEditedDateTime(String? value) {
    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(
      now.year,
      now.month,
      now.day,
    );
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
