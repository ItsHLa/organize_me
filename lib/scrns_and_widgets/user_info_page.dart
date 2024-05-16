import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/icon_Form.dart';
import 'package:organize_me/user_cubit/user_cubit.dart';

import 'add_data_page.dart';

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

class EditUserInfo extends StatefulWidget {
  const EditUserInfo({super.key});

  @override
  State<EditUserInfo> createState() => _EditUserInfoState();
}

class _EditUserInfoState extends State<EditUserInfo> {
  List labels = ['اسم المستخدم', 'عنوان البريد الالكتروني', 'كلمة السر'];
  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: InputDataPage(
        controllers: controllers,
        labels: labels,
        save: [
          (value) {
            controllers[0].text = value!;
          },
          (value) {
            controllers[1].text = value!;
          },
          (value) {
            controllers[2].text = value!;
          }
        ],
        onPressed: () {
          key.currentState?.save();
          log(controllers.toString());
        },
        labelButton: 'تعديل',
        icon: Icons.edit_outlined,
      ),
    );
  }
}

/*
* const Column(
        children: [
          ,
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
      )
* */

/*
* child:SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: labels.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: InputText(
                  hint: '',
                  labelText:labels[index] ,
                  save: (value) {
                    info[index] = value!;
                  },
                ),
              );
            },
        ),
      ) */