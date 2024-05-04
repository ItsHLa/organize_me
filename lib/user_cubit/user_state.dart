part of 'user_cubit.dart';

@immutable
sealed class UserState {
  final String userName;
  final String email;

  UserState({required this.userName, required this.email});
}

final class UserInitial extends UserState {
  UserInitial({required super.userName, required super.email});
}

final class UserInfoLoaded extends UserState {
  UserInfoLoaded({required super.userName, required super.email});
}
