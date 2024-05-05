import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial(userName: '', email: ''));

  Future<void> loadUserInfo() async {
    Map<String, String> info = await User.userInfo();
    emit(UserInfoLoaded(userName: info['userName']!, email: info['email']!));
  }
}
