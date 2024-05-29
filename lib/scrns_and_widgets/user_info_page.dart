import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/services/functionality.dart';
import 'package:organize_me/user_cubit/user_cubit.dart';

import 'input_text.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo(
      {super.key,
      required this.id,
      required this.userName,
      required this.password,
      required this.email});

  final String id;
  final String userName;
  final String password;
  final String email;

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  List labels = ['اسم المستخدم', 'البريد الالكتروني', 'كلمة السر'];

  TextEditingController id = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  List validator = const [
    ValidateInputData.checkIfNull,
    ValidateInputData.checkIfNull,
    ValidateInputData.checkIfNull,
  ];

  GlobalKey<FormState> key = GlobalKey();

  @override
  void initState() {
    id.text = widget.id;
    userName.text = widget.userName;
    email.text = widget.email;
    password.text = widget.password;
    super.initState();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    List controllers = [userName, email, password];
    List save = [
      (value) {
        setState(() {
          userName.text = value!;
        });
      },
      (value) {
        setState(() {
          email.text = value!;
        });
      },
      (value) {
        password.text = value!;
      }
    ];
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is Loading) {
          setState(() {
            loading = true;
          });
        } else if (state is UserInfoLoaded) {
          Navigator.of(context).pop();
        } else if (state is Failed) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('حصل خطأ اثناء التعديل يرجى اعادة محاولة')));
        } else if (state is NoInternet) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تحقق من اتصالك بالانترنت'),
            ),
          );
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Row(
              children: [
                Spacer(),
                Text(
                  'صفحتك الشخصية',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  width: 6,
                ),
                Icon(
                  Icons.account_circle_outlined,
                  size: 25,
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
          body: Form(
            key: key,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  height: 70.0 * labels.length,
                  child: ListView.builder(
                    itemCount: labels.length,
                    itemBuilder: (context, index) {
                      return InputText(
                        labelText: labels[index],
                        controller: controllers[index],
                        validator: validator[index],
                        save: save[index],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColorTheme,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        if (ValidateInputData.validateField(key)) {
                          key.currentState?.save();
                          BlocProvider.of<UserCubit>(context).editUserInfo(
                              id: int.parse(id.text),
                              email: email.text,
                              userName: userName.text,
                              password: password.text);
                        }
                      },
                      child: Center(
                        child: loading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white54,
                                ),
                              )
                            : const Text(
                                'تعديل الحساب',
                                style: TextStyle(color: Colors.white),
                              ),
                      )),
                ),
                // InputDataPage(
                //   controllers: [userName, email, password],
                //   labels: labels,
                //   validator: const [
                //     ValidateInputData.checkIfNull,
                //     ValidateInputData.checkIfNull,
                //     ValidateInputData.checkIfNull,
                //   ],
                //   save: [
                //         (value) {
                //       setState(() {
                //         userName.text = value!;
                //       });
                //     },
                //         (value) {
                //       setState(() {
                //         email.text = value!;
                //       });
                //     },
                //         (value) {
                //       password.text = value!;
                //     }
                //   ],
                //   onPressed: () {
                //     if (ValidateInputData.validateField(key)) {
                //       key.currentState?.save();
                //       print(userName.text);
                //       print(email.text);
                //       print(password.text);
                //       BlocProvider.of<UserCubit>(context).editUserInfo(
                //           id: int.parse(id.text),
                //           email: email.text,
                //           userName: userName.text,
                //           password: password.text);
                //     }
                //   },
                //   labelButton: 'تعديل',
                //   icon: Icons.edit_outlined,
                // ),
              ],
            ),
          )),
    );
  }
}

/*
*
*
* listener: (context, state) {
        if (state is UserInfoLoaded) {
          Navigator.of(context).pop();
        } else if (state is Failed) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('حصل خطأ اثناءالتعديل يرجى اعادة محاولة')));
        } else if (state is NoInternet) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تحقق من اتصالك بالانترنت'),
            ),
          );
        }
      },
*
*
*
* SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InputText(
                          save: (){
                          },
                          labelText:'اسم المستخدم' ,
                          controller: userName
                        )
                        ListTile(
                          trailing: const Icon(Icons.person_outline),
                          title: const Text(
                            ,
                            textAlign: TextAlign.right,
                          ),
                          subtitle:
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
            )
*
* */

