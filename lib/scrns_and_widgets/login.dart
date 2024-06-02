import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/home_page.dart';
import 'package:organize_me/services/functionality.dart';

import '../user_cubit/user_cubit.dart';
import 'input_text.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> userKey = GlobalKey();

  String email = '';
  String password = '';


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم تسجيل الدخول بنجاح'),
              duration: Duration(seconds: 4),
            ),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        } else if (state is LoginFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('حصل خطأ اثناء تسجيل الدخول يرجى اعادة محاولة'),
            ),
          );
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
                      height: 90, child: Image.asset('images/app_icon.jpg')),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    alignment: Alignment.centerRight,
                    child: const Text(
                      ' سجل دخول',
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  InputText(
                    labelText: 'ايميل',
                    save: (value) {
                      setState(
                        () {
                          email = value!;
                        },
                      );
                    },
                    validator: ValidateInputData.validateEmail,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InputText(
                    labelText: 'كلمة السر',
                    save: (value) {
                      setState(
                        () {
                          password = value!;
                        },
                      );
                    },
                    validator: ValidateInputData.validatePassword,
                  ),
                  const SizedBox(
                    height: 5,
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
                            BlocProvider.of<UserCubit>(context)
                                .login(email, password);
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
                            'سجل دخول',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                    ),
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
