part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class CheckIfSigned extends UserState {
  final bool signed;

  CheckIfSigned(this.signed);
}

final class UserInfoLoaded extends UserState {
  final int id;
  final String email;

  final String password;
  final String username;

  UserInfoLoaded({
    required this.id,
    required this.email,
    required this.password,
    required this.username,
  });
}

final class UserInfoEdited extends UserState {
  final int id;
  final String email;

  final String password;
  final String username;

  UserInfoEdited({
    required this.id,
    required this.email,
    required this.password,
    required this.username,
  });
}

final class Failed extends UserState {}

final class Loading extends UserState {}

final class LoginSuccess extends UserState {}

final class LoginFailed extends UserState {}

final class RegisterSuccess extends UserState {}

final class RegisterFailed extends UserState {}

final class NoInternet extends UserState {}
