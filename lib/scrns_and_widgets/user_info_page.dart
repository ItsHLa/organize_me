import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/icon_Form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  void initState() {
    userInfo();
  }

  Map<String, String>? info;

  Future<void> userInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> userInfo = {
      'userName': preferences.getString('userName')!,
      'email': preferences.getString('email')!,
      'password': preferences.getString('password')!
    };
    info = userInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const IconForm(
                child: Icon(
              Icons.person_outlined,
              size: 50,
            )),
            const SizedBox(
              height: 15,
            ),
            ListTile(
              title: Text('User Name'),
              // subtitle: Text('HLa Nissani'),
            ),
            ListTile(
              title: Text('Email'),
              //  subtitle: Text(),
            ),
            ListTile(
              title: Text('Password'),
            )
          ],
        ),
      ),
    );
  }
}
