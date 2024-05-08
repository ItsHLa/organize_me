part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserInfoLoaded extends UserState {}

final class LoggingInLoading extends UserState {}

final class LoggingInSuccess extends UserState {}

final class LoggingInFailed extends UserState {}
