import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/register.dart';
import 'package:organize_me/user_cubit/user_cubit.dart';
import 'package:organize_me/user.dart';

import 'add_data_page.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).loadUserInfo();
    log(me.toString());
    super.initState();
  }

  TextEditingController id = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserInfoLoaded) {
          id.text = state.id.toString();
          userName.text = state.username;
          email.text = state.email;
          password.text = state.password;
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 10,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => EditUserInfo(
                                        userName: userName.text,
                                        password: password.text,
                                        email: email.text,
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit_outlined,
                                  )),
                              const Spacer(),
                              const Text(
                                'معلوماتك الشخصية',
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              const Icon(
                                Icons.person_outlined,
                                size: 25,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ListTile(
                          trailing: const Icon(Icons.numbers),
                          title: const Text(
                            'id',
                            textAlign: TextAlign.right,
                          ),
                          subtitle: Text(
                            id.text,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          trailing: const Icon(Icons.person_outline),
                          title: const Text(
                            'اسم المستخدم',
                            textAlign: TextAlign.right,
                          ),
                          subtitle: Text(
                            userName.text,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          trailing: const Icon(Icons.alternate_email),
                          title: const Text(
                            'عنوان البريد الالكتروني',
                            textAlign: TextAlign.right,
                          ),
                          subtitle: Text(
                            email.text,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const Divider(),
                        const ListTile(
                          trailing: Icon(Icons.apps),
                          title: Text(
                            'نسخة النطبيق',
                            textAlign: TextAlign.right,
                          ),
                          subtitle: Text(
                            ' v.0',
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const Divider(),
                        const ListTile(
                          trailing: Icon(Icons.attach_email_outlined),
                          title: Text(
                            'تواصل معنا',
                            textAlign: TextAlign.right,
                          ),
                          subtitle: Text(
                            'organizeme@gmail.com',
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          trailing: const Icon(Icons.logout),
                          title: const Text(
                            'تسجيل خروج',
                            textAlign: TextAlign.right,
                          ),
                          onTap: () async {
                            await User.signUser(false);
                            if (context.mounted) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const Register(),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
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
  const EditUserInfo(
      {super.key,
      required this.userName,
      required this.password,
      required this.email});

  final String userName;
  final String password;
  final String email;

  @override
  State<EditUserInfo> createState() => _EditUserInfoState();
}

class _EditUserInfoState extends State<EditUserInfo> {
  List labels = ['اسم المستخدم', 'عنوان البريد الالكتروني', 'كلمة السر'];

  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    userName.text = widget.userName;
    email.text = widget.email;
    password.text = widget.password;
    return Form(
      key: key,
      child: InputDataPage(
        controllers: [userName, email, password],
        labels: labels,
        save: [
          (value) {
            userName.text = value!;
          },
          (value) {
            email.text = value!;
          },
          (value) {
            password.text = value!;
          }
        ],
        onPressed: () {
          key.currentState?.save();
        },
        labelButton: 'تعديل',
        icon: Icons.edit_outlined,
      ),
    );
  }
}
