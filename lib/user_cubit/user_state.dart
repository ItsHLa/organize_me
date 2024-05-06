part of 'user_cubit.dart';

@immutable
sealed class UserState {
  final String username;
  final String email;

  const UserState({required this.username, required this.email});
}

final class UserInitial extends UserState {
  const UserInitial({required super.username, required super.email});
}

final class UserInfoLoaded extends UserState {
  const UserInfoLoaded({required super.username, required super.email});
}
