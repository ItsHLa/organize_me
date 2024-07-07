import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/register.dart';
import 'package:organize_me/services/functionality.dart';
import 'package:organize_me/user_cubit/user_cubit.dart';

import '../user.dart';
import 'input_text.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({
    super.key,
  });

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  List labels = [
    'اسم المستخدم',
    'البريد الالكتروني',
    'كلمة السر القديمة',
    'كلمة السر الجديدة'
  ];
  List<bool> obscureText = [false, false, true, true];

  TextEditingController id = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  String? userPassword;
  TextEditingController newPassword = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    List prefixIcon = [
      null,
      null,
      IconButton(
        onPressed: () {
          setState(() {
            obscureText[2] = !obscureText[2];
          });
        },
        icon: Icon(
          Icons.remove_red_eye,
          color: obscureText[2] ? Colors.grey : appColorTheme,
        ),
      ),
      IconButton(
        onPressed: () {
          setState(() {
            obscureText[3] = !obscureText[3];
          });
        },
        icon: Icon(
          Icons.remove_red_eye,
          color: obscureText[3] ? Colors.grey : appColorTheme,
        ),
      )
    ];
    List validator = [
      ValidateInputData.checkIfNull,
      ValidateInputData.checkIfNull,
      (value) {
        return ValidateInputData.checkPassword(userPassword, oldPassword.text);
      },
      ValidateInputData.checkIfNull,
    ];
    List controllers = [userName, email, oldPassword, newPassword];
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
        oldPassword.text = value!;
      },
      (value) {
        newPassword.text = value ?? userPassword;
      }
    ];
    BlocProvider.of<UserCubit>(context).loadUserInfo();
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is Loading) {
          setState(() {
            loading = true;
          });
        } else if (state is UserInfoLoaded) {
          id.text = state.id.toString();
          userName.text = state.username;
          email.text = state.email;
          userPassword = state.password;
          print(userPassword);
        } else if (state is Failed) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('حصل خطأ اثناء التعديل يرجى اعادة محاولة')));
        } else if (state is NoInternet) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تحقق من اتصالك بالانترنت'),
            ),
          );
        } else if (state is UserInfoEdited) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'صفحتك الشخصية',
              style: TextStyle(fontSize: 18),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () async {
                    await User.signUser(false);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const Register(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout))
            ],
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
                        prefixIcon: prefixIcon[index],
                        obscureText: obscureText[index],
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
                              password: newPassword.text);
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
              ],
            ),
          )),
    );
  }
}
