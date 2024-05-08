part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserInfoLoaded extends UserState {}

final class Loading extends UserState {}

final class Success extends UserState {}

final class Failed extends UserState {}
