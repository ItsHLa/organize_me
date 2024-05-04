/*part of 'customize_cubit.dart';

@immutable
sealed class CustomizeState {
  final String userName;
  final String email;
  final String password;
  final bool darkMode;

  const CustomizeState( {
    required this.userName,
    required this.email,
    required this.password,
    required this.darkMode,
  });
}

final class CustomizeInitial extends CustomizeState {
  const CustomizeInitial({required super.userName, required super.email, required super.password, required super.darkMode});

}

final class Customize extends CustomizeState {
  const Customize({
    required super.darkMode,
   required super.userName, required super.email, required super.password,
  });
}
*/
