import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/icon_Form.dart';
import 'package:organize_me/user_cubit/user_cubit.dart';

import 'add_data_page.dart';
import 'input_text.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserCubit>(context).loadUserInfo();
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserInfoLoaded) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Spacer(),
                                  Container(
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                const EditUserInfo(),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.edit_outlined,
                                          color: appColorTheme,
                                        )),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              ListTile(
                                title: const Text('اسم المستخدم'),
                                subtitle: Text(state.username),
                              ),
                              ListTile(
                                title: const Text('عنوان البريد الالكتروني'),
                                subtitle: Text(state.email),
                              ),
                              ListTile(
                                title: const Text('كلمة السر'),
                                subtitle: Text(state.password),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -4,
                        left: -4,
                        child: IconForm(
                            child: Icon(
                          Icons.person_outlined,
                          size: 50,
                          color: appColorTheme,
                        )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class EditUserInfo extends StatelessWidget {
  const EditUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return InputDataPage(
      onPressed: () {},
      label: 'تعديل',
      icon: Icons.edit_outlined,
      child: const Column(
        children: [
          InputText(
            hint: '',
            labelText: 'اسم المستخدم',
          ),
          SizedBox(
            height: 5,
          ),
          InputText(
            hint: '',
            labelText: 'عنوان البريد الالكتروني',
          ),
          SizedBox(
            height: 5,
          ),
          InputText(
            hint: '',
            labelText: 'كلمة السر',
          ),
        ],
      ),
    );
  }
}
