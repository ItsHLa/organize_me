import 'dart:async';

import 'package:telephony/telephony.dart';

class TelephonyService {
  static Telephony telephony = Telephony.instance;

  static Future<bool?> askForPermission() async {
    return await telephony.requestPhoneAndSmsPermissions;
  }

  static getInboxSms() async {
    List sms = await telephony.getInboxSms();
    List MySms = [];
    for (int i = 0; i < sms.length; i++) {
      if (sms[i].address == 'SyriatelSEP') {
        print(sms[i].body);
      }
    }
  }

  static void listenForIncomingSms() {
    void startSmsListener() {
      telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) {
          if (message.address == 'SyriatelSEP') {
            print(message.body);
          }

          //print('Received SMS : ${message.body.toString()}');

          // we will pass the body of message here based on contact address
        },
      );
    }
  }
}

void onBackgroundMessage(SmsMessage message) async {
// same code  for listener ...
  print("Received SMS on background : ${message.body}");
}
