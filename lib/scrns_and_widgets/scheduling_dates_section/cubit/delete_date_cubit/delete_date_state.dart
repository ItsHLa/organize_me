part of 'delete_date_cubit.dart';

@immutable
sealed class DeleteDateState {}

final class DeleteDateInitial extends DeleteDateState {}

final class DeleteDateLoading extends DeleteDateState {}

final class DeleteDateSucsses extends DeleteDateState {}

final class DeleteDateFaild extends DeleteDateState {
  String? msg;

  DeleteDateFaild({required this.msg});
}