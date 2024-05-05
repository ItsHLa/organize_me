import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/icon_Form.dart';
import 'package:organize_me/user_cubit/user_cubit.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserCubit>(context).loadUserInfo();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const IconForm(
                child: Icon(
              Icons.person_outlined,
              size: 50,
            )),
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return ListTile(
                  title: const Text('اسم المستخدم'),
                  subtitle: Text(state.userName),
                );
              },
            ),
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return ListTile(
                  title: const Text('عنوان البريد الالكتروني'),
                  subtitle: Text(state.email),
                );
              },
            ),
            const ListTile(
              title: Text('Password'),
            )
          ],
        ),
      ),
    );
  }
}
