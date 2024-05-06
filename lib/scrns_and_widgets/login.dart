import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/home_page.dart';
import 'package:organize_me/scrns_and_widgets/icon_Form.dart';
import 'package:organize_me/services/api_calls.dart';
import 'package:organize_me/services/functionality.dart';
import 'package:organize_me/user.dart';

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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColorTheme,
                  shape: const StadiumBorder(),
                ),
                onPressed: () async {
                  if (ValidateInputData.validateField(userKey)) {
                    userKey.currentState?.save();
                    Response r = await login(email, password);
                    await User.setUserInfo(
                      username: 'username', // get it from the response
                      email: email,
                      password: password,
                    );
                    if (context.mounted) {
                      if (r.statusCode == 200) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      }
                    }
                  }
                },
                child: const Text(
                  'سجل دخول',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
