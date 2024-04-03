part of 'add_date_cubit.dart';

@immutable
sealed class DateState {}

final class DateInitial extends DateState {}

final class AddDateLoading extends DateState {}

final class AddDateSucsses extends DateState {}

final class AddDateFaild extends DateState {
  final String? msg;

  AddDateFaild({required this.msg});
}
