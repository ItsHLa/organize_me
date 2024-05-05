import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserInitial(userName: '', email: ''));

  Future<void> loadUserInfo() async {
    Map<String, String> info = await User.userInfo();
    emit(
      UserInfoLoaded(
        userName: info['userName']!,
        email: info['email']!,
      ),
    );
  }
}
