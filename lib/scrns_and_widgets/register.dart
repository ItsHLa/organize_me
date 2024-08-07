import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/home_page.dart';
import 'package:organize_me/scrns_and_widgets/login.dart';
import 'package:organize_me/user_cubit/user_cubit.dart';

import '../services/functionality.dart';
import '../user.dart';
import 'input_text.dart';

class Register extends StatefulWidget {
  const Register({
    super.key,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> userKey = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('تم انشاء حساب بنجاح'),
            duration: Duration(seconds: 4),
          ));
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        } else if (state is RegisterFailed) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('حصل خطأ اثناء انشاء حساب يرجى اعادة محاولة')));
        } else if (state is NoInternet) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تحقق من اتصالك بالانترنت'),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: userKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    height: 80,
                    child: Image.asset('images/app_icon.png'),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    alignment: Alignment.centerRight,
                    child: const Text(
                      'انشاء حساب',
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputText(
                    labelText: 'اسم المستخدم',
                    save: (value) {
                      setState(() {
                        username.text = value!;
                      });
                    },
                    validator: ValidateInputData.checkIfNull,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InputText(
                    labelText: 'ايميل',
                    save: (value) {
                      setState(
                        () {
                          email.text = value!;
                        },
                      );
                    },
                    validator: ValidateInputData.validateEmail,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InputText(
                    controller: password,
                    obscureText: hidePassword,
                    prefixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: hidePassword ? Colors.grey : appColorTheme,
                      ),
                    ),
                    labelText: 'كلمة السر',
                    save: (value) {
                      setState(
                        () {
                          password.text = value!;
                        },
                      );
                    },
                    validator: ValidateInputData.validatePassword,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          child: Text(
                            'سجل دخول',
                            style: TextStyle(color: appColorTheme),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ),
                            );
                          }),
                      const Text('لديك حساب مسبقا؟'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appColorTheme,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () async {
                          if (ValidateInputData.validateField(userKey)) {
                            userKey.currentState?.save();
                            User user = User(
                              email: email.text,
                              password: password.text,
                              username: username.text,
                            );
                            BlocProvider.of<UserCubit>(context).register(user);
                          }
                        },
                        child: Center(
                          child: state is Loading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white54,
                                  ),
                                )
                              : const Text(
                                  'انشاء حساب',
                                  style: TextStyle(color: Colors.white),
                                ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
