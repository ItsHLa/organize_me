import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/register.dart';
import 'package:organize_me/scrns_and_widgets/user_info_page.dart';
import 'package:organize_me/user.dart';
import 'package:organize_me/user_cubit/user_cubit.dart';

class MyDarwer extends StatefulWidget {
  const MyDarwer({super.key});

  @override
  State<MyDarwer> createState() => _MyDarwerState();
}

class _MyDarwerState extends State<MyDarwer> {
  List<String> label = [
    'نسخة التطيبق',
    ' تواصل معنا',
    'تسجيل خروج',
  ];

  List<String> subTitle = [
    'v0',
    'organizeme@gmail.com',
    '',
  ];

  List<Widget> leading = [
    const Icon(Icons.apps_outlined),
    const Icon(Icons.attach_email_outlined),
    const Icon(Icons.logout)
  ];

  @override
  Widget build(BuildContext context) {
    List<void Function()?> onTap = [
      null,
      null,
          () async {
        await User.signUser(false);
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Register(),
            ),
          );
        }
      },
    ];
    BlocProvider.of<UserCubit>(context).loadUserInfo();
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserInfoLoaded) {
                  log(state.email);
                  log(state.username);
                  return ListTile(
                    title: Text(state.username),
                    subtitle: Text(state.email),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AccountInfo(
                            id: state.id.toString(),
                            email: state.email,
                            password: state.password,
                            userName: state.username,
                          ),
                        ));
                      },
                      icon: const Icon(Icons.edit_outlined),
                    ),
                  );
                } else {
                  return Container(
                    color: Colors.red,
                  );
                }
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) => ListTile(
                onTap: onTap[index],
                title: Text(
                  label[index],
                  textAlign: TextAlign.right,
                ),
                subtitle: Text(
                  subTitle[index],
                  textAlign: TextAlign.right,
                ),
                trailing: leading[index],
              ),
              itemCount: leading.length,
            ),
          ),
        ],
      ),
    );
  }
}