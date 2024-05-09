import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/home_page.dart';
import 'package:organize_me/scrns_and_widgets/icon_Form.dart';
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
  String username = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if(state is RegisterSuccess){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('تم انشاء حساب بنجاح'),
            duration: Duration(seconds: 4),
          ));
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
        }else if(state is RegisterFailed){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('حصل خطأ اثناء انشاء حساب يرجى اعادة محاولة')));
        }else if (state is NoInternet) {
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
                  const SizedBox(height: 60,),
                  const IconForm(
                      child: Icon(
                        Icons.person_outlined,
                        size: 50,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'هل تريد ربط فواتيرك بعنوان بريدك الالكتروني ؟',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputText(
                      labelText: 'اسم المستخدم',
                      save: (value) {
                        setState(() {
                          username = value!;
                        });
                      },
                      validator: ValidateInputData.checkIfNull,
                      hint: '',
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputText(
                      labelText: 'ايميل',
                      save: (value) {
                        setState(
                              () {
                            email = value!;
                          },
                        );
                      },
                      validator: ValidateInputData.validateEmail,
                      hint: '',
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputText(
                      labelText: 'كلمة السر',
                      save: (value) {
                        setState(
                              () {
                            password = value!;
                          },
                        );
                      },
                      validator: ValidateInputData.validatePassword,
                      hint: '',
                    ),
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Login()));
                        },
                      ),
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
                              email: email,
                              password: password,
                              username: username,
                            );
                            BlocProvider.of<UserCubit>(context).register(user);
                            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
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

/*
* if (context.mounted) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      }
*
* */