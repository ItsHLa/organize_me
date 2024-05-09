part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserInfoLoaded extends UserState {}

final class Loading extends UserState {}

final class LoginSuccess extends UserState {}

final class LoginFailed extends UserState {}

final class RegisterSuccess extends UserState {}

final class RegisterFailed extends UserState {}

final class NoEnternet extends UserState {}
