import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants.dart';

// a function to request permissions from user
Future<void> requestPermission(Permission permission) async {
  await permission.isDenied.then((value) {
    if (value) {
      permission.request();
    }
  });
}

// a function that convert String to DateTime
DateTime convertStringToDateTime(String value) {
  List<String>? parts = value.split('-');
  int year = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int day = int.parse(parts[2]);
  DateTime date = DateTime(year, month, day);
  return date;
}

// a function that convert  DateTime to String
TimeOfDay convertStringToTimeDay(String value) {
  List<String>? parts = value.split(':');
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);
  TimeOfDay timeOfDay = TimeOfDay(hour: hour, minute: minute);
  return timeOfDay;
}

// a function that calculate the difference between Times
Duration differenceBetweenTimes(TimeOfDay timeOfDay) {
  DateTime now = DateTime.now();
  DateTime dateTime =
      DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  Duration duration = dateTime.difference(now);
  return duration;
}

// a function that convert  timeOfDay to Duration
Duration timeOfDayToDuration(TimeOfDay timeOfDay) {
  // Create a DateTime object with today's date and the time from TimeOfDay
  DateTime now = DateTime.now();
  DateTime dateTime = DateTime(
    now.year,
    now.month,
    now.day,
    timeOfDay.hour,
    timeOfDay.minute,
  );

  // Calculate the difference between now and the specified time
  Duration duration = dateTime.difference(now);

  // Handle the case when the specified time is before the current time
  if (duration.isNegative) {
    // Add a day to make the duration positive
    duration += const Duration(days: 1);
  }

  return duration;
}

// class with functions  that validate the input
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

  static String? checkPassword(String? value, String password) {
    if (value?.isEmpty ?? true) {
      return 'هذا الحقل لا يمكن ان يكون فارغ';
    } else if (!(password.compareTo(value!) == 0)) {
      return 'كلمة السر غير متطابقة';
    } else {
      return null;
    }
  }

  static String? checkClinicNumber(String? value) {
    if (value?.isEmpty ?? true) {
      return 'هذا الحقل لا يمكن ان يكون فارغ';
    }
    int phoneNumber = int.parse(value!);
    if (phoneNumber.isNegative) {
      return 'هذا الحقل لا يمكن ان يكون يحوي اعداد سالبة';
    } else if (value.length < 7) {
      return 'هذا الحقل لا يمكن ان يكون اقل من 7 ارقام';
    } else if (value.length > 7) {
      return 'هذا الحقل لا يمكن ان يكون اكبر من 7 ارقام';
    } else {
      return null;
    }
  }

  static String? checkEditedClinicNumber(String? value) {
    int phoneNumber = int.parse(value!);
    if (phoneNumber.isNegative) {
      return 'هذا الحقل لا يمكن ان يكون يحوي اعداد سالبة';
    } else if (value.length < 7) {
      return 'هذا الحقل لا يمكن ان يكون أقل من 7 ارقام';
    } else if (value.length > 7) {
      return 'هذا الحقل لا يمكن ان يكون اكبر من 7 ارقام';
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
    } else if (value.length > 10) {
      return 'هذا الحقل لا يمكن ان يكون اكبر من 10 ارقام';
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

  static checkTaskInterval(String? value, String? startTime, String? dateTime) {
    if (value!.isEmpty) {
      return 'هذا الحقل لا يمكن ان يكون فارغ';
    } else if (startTime!.isEmpty || dateTime!.isEmpty) {
      return 'لا يمكن ان يكون اليوم او وقت البدء فارغ';
    } else if (value.isNotEmpty) {
      TimeOfDay timeNow = TimeOfDay.now();
      DateTime fullDateNow = DateTime.now();
      DateTime dateNow = DateTime(
        fullDateNow.year,
        fullDateNow.month,
        fullDateNow.day,
      );
      DateTime date = convertStringToDateTime(dateTime);
      TimeOfDay start = convertStringToTimeDay(startTime);
      int diffInMinutes =
          ((start.hour - timeNow.hour) * 60) + (start.minute - timeNow.minute);
      int preAlarm = int.parse(value);
      if ((value.length) > 10) {
        return 'هذا الحقل لا يمكن أن يكون أكبر من 10 أرقام';
      } else if ((date.isAtSameMomentAs(dateNow)) &&
          preAlarm >= diffInMinutes) {
        return 'هذا الحقل يجب أن يكون أصغر من فرق الوقت بين الآن و وقت البدء';
      }
    } else {
      return null;
    }
  }

  static checkEditedTaskInterval(
      String? value, String? editedStart, String? editedDate) {
    if (value!.isNotEmpty &&
        editedStart!.isNotEmpty &&
        editedDate!.isNotEmpty) {
      TimeOfDay timeNow = TimeOfDay.now();
      DateTime fullDateNow = DateTime.now();
      DateTime dateNow = DateTime(
        fullDateNow.year,
        fullDateNow.month,
        fullDateNow.day,
      );
      DateTime date = convertStringToDateTime(editedDate);
      TimeOfDay start = convertStringToTimeDay(editedStart);
      int diffInMinutes =
          ((start.hour - timeNow.hour) * 60) + (start.minute - timeNow.minute);
      int preAlarm = int.parse(value);
      if ((value.length) > 10) {
        return 'هذا الحقل لا يمكن أن يكون أكبر من 10 أرقام';
      } else if ((date.isAtSameMomentAs(dateNow)) &&
          preAlarm >= diffInMinutes) {
        return 'هذا الحقل يجب أن يكون أصغر من فرق الوقت بين الآن و وقت البدء';
      }
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

  static String? checkStartTime(String? value, String? selectedDate) {
    if (value!.isEmpty) {
      return 'هذا الحقل لا يمكن ان يكون فارغ';
    } else if (selectedDate!.isEmpty) {
      return ' لا يمكن اليوم ان يكون فارغ';
    } else if (selectedDate.isNotEmpty) {
      TimeOfDay current = TimeOfDay.now();
      DateTime now = DateTime.now();
      DateTime currentTime =
          DateTime(now.year, now.month, now.day, current.hour, current.minute);
      DateTime selectDate = convertStringToDateTime(selectedDate);
      TimeOfDay selectTime = convertStringToTimeDay(value);
      DateTime scheduledTime = DateTime(
        selectDate.year,
        selectDate.month,
        selectDate.day,
        selectTime.hour,
        selectTime.minute,
      );
      if (scheduledTime.isBefore(currentTime)) {
        return 'لا يمكن ان يكون الوقت المختار اقل من الوقت الحالي';
      }
    } else {
      return null;
    }
    return null;
  }

  static String? checkEditedStartTime(String? value, String? selectedDate) {
    if (selectedDate!.isNotEmpty && value!.isNotEmpty) {
      TimeOfDay current = TimeOfDay.now();
      DateTime now = DateTime.now();
      DateTime currentTime =
          DateTime(now.year, now.month, now.day, current.hour, current.minute);
      DateTime selectDate = convertStringToDateTime(selectedDate);
      TimeOfDay selectTime = convertStringToTimeDay(value);
      DateTime scheduledTime = DateTime(
        selectDate.year,
        selectDate.month,
        selectDate.day,
        selectTime.hour,
        selectTime.minute,
      );
      if (scheduledTime.isBefore(currentTime)) {
        return 'لا يمكن ان يكون الوقت المختار اقل من الوقت الحالي';
      }
    } else {
      return null;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'لا يمكن لهذا الحقل ان يكون فارغ';
    }
    if (value.length < 5) {
      return 'كلمة السر يجب ان تكون على الاقل 5 محارف';
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email!.isEmpty) {
      return 'لا يمكن لهذا الحقل ان يكون فارغ';
    }
    if (!RegExp(r'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[com]{2,}\b',
            caseSensitive: false)
        .hasMatch(email)) {
      return 'من فضلك أدخل عنوان بريد صالح';
    }
    return null;
  }

  static String? checkDateTime(String? value) {
    if (value?.isEmpty ?? true) {
      return 'هذا الحقل لا يمكن ان يكون فارغ';
    } else if (value!.isNotEmpty) {
      DateTime now = DateTime.now();
      DateTime currentDate = DateTime(
        now.year,
        now.month,
        now.day,
      );
      DateTime date = convertStringToDateTime(value);
      if (date.isBefore(currentDate.toUtc())) {
        return 'لا يمكن ان يكون اليوم قبل اليوم الحالي';
      }
    } else {
      return null;
    }
    return null;
  }

  static String? checkEditedDateTime(String? value) {
    if (value!.isNotEmpty) {
      DateTime now = DateTime.now();
      DateTime currentDate = DateTime(
        now.year,
        now.month,
        now.day,
      );
      List<String>? parts = value.split('-');
      int year = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int day = int.parse(parts[2]);
      DateTime date = DateTime(year, month, day);
      if (date.isBefore(currentDate.toUtc())) {
        return 'لا يمكن ان يكون اليوم قبل اليوم الحالي';
      }
    } else {
      return null;
    }
    return null;
  }
}

// a function that showTimePicker
Future<TimeOfDay?> showTime(BuildContext context) async {
  return await showTimePicker(
      context: context,
      confirmText: 'موافق',
      cancelText: 'الغاء',
      errorInvalidText: 'لا يمكن ان يكون اليوم قبل اليوم الحالي',
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              dialBackgroundColor: appColorTheme,
              dayPeriodColor: appColorTheme,
              cancelButtonStyle: TextButton.styleFrom(
                foregroundColor: appColorTheme,
              ),
              confirmButtonStyle: TextButton.styleFrom(
                foregroundColor: appColorTheme,
              ),
              // hourMinuteColor: appColorTheme,
              // hourMinuteShape: const RoundedRectangleBorder(),
              inputDecorationTheme: InputDecorationTheme(
                hintStyle: TextStyle(color: appColorTheme),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: appColorTheme,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: appColorTheme,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: appColorTheme,
                  ),
                ),
                labelStyle: TextStyle(color: appColorTheme),
              ),
            ),
          ),
          child: child!,
        );
      },
      initialTime: TimeOfDay.now());
}

// a function that showDatePicker
Future<DateTime?> showDate(BuildContext context) async {
  return await showDatePicker(
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          datePickerTheme: DatePickerThemeData(
              rangePickerBackgroundColor: appColorTheme,
              surfaceTintColor: appColorTheme,
              rangeSelectionBackgroundColor: appColorTheme),
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.grey,
            cursorColor: appColorTheme,
            selectionHandleColor: appColorTheme,
          ),
          inputDecorationTheme: InputDecorationTheme(
            activeIndicatorBorder: BorderSide(color: appColorTheme),
            hintStyle: TextStyle(color: appColorTheme),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: appColorTheme,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: appColorTheme,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: appColorTheme,
              ),
            ),
            labelStyle: TextStyle(color: appColorTheme),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: appColorTheme, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
    confirmText: 'موافق',
    cancelText: 'الغاء',
    currentDate: DateTime.now(),
    context: context,
    firstDate: DateTime(2024),
    lastDate: DateTime(3000),
    initialEntryMode: DatePickerEntryMode.input,
    errorFormatText: 'خطأ في الصيغة',
    errorInvalidText: 'لا يمكن ان يكون الوقت قبل الوقت الحالي',
    initialDate: DateTime.now(),
  );
}

// to format date in database to be compatible with api
extension SwappableList<E> on List<E> {
  List swap(int first, int second) {
    final temp = this[first];
    this[first] = this[second];
    this[second] = temp;
    return this;
  }
}
