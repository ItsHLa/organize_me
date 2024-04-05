part of 'add_date_cubit.dart';

@immutable
sealed class AddAppointmentState {}

final class AppointmentInitial extends AddAppointmentState {}

final class AddAppointmentLoading extends AddAppointmentState {}

final class AddAppointmentSucsses extends AddAppointmentState {}

final class AddAppointmentFailed extends AddAppointmentState {
  final String msg;

  AddAppointmentFailed({required this.msg});
}
