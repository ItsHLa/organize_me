part of 'add_date_cubit.dart';

@immutable
sealed class AddDateState {}

final class DateInitial extends AddDateState {}

final class AddDateLoading extends AddDateState {}

final class AddDateSucsses extends AddDateState {}

final class AddDateFaild extends AddDateState {
  final String msg;

  AddDateFaild({required this.msg});
}
