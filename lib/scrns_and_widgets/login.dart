import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/home_page.dart';
import 'package:organize_me/scrns_and_widgets/icon_Form.dart';
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
        if (state is LoggingInSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('تم تسجيل الدخول بنجاح'),
            duration: Duration(seconds: 4),
          ));
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
        }
        if (state is LoggingInFailed) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('حصل خطأ اثناء تسجيل الدخول يرجى اعادة محاولة')));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Form(
              key: userKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const IconForm(
                    child: Icon(
                      Icons.person_outlined,
                      size: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    ' سجل دخول',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputText(
                      hint: 'ايميل',
                      save: (value) {
                        setState(
                          () {
                            email = value!;
                          },
                        );
                      },
                      validator: ValidateInputData.validateEmail,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputText(
                      hint: 'كلمة السر',
                      save: (value) {
                        setState(
                          () {
                            password = value!;
                          },
                        );
                      },
                      validator: ValidateInputData.validatePassword,
                    ),
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
                              .userLogin(email, password);
                        }
                      },
                      child: state is LoggingInLoading
                          ? const Center(
                              child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white54,
                                  )),
                            )
                          : const Center(
                              child: Text(
                                'سجل دخول',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
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
