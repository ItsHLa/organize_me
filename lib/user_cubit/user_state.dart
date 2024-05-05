part of 'user_cubit.dart';

@immutable
sealed class UserState {
  final String userName;
  final String email;

  const UserState({required this.userName, required this.email});
}

final class UserInitial extends UserState {
  const UserInitial({required super.userName, required super.email});
}

final class UserInfoLoaded extends UserState {
  const UserInfoLoaded({required super.userName, required super.email});
}
