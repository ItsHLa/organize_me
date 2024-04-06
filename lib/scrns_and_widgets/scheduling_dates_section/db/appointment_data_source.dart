import 'package:syncfusion_flutter_calendar/calendar.dart';

AppointmentDataSource getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];
  return AppointmentDataSource(appointments);
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
