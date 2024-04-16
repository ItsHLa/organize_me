import 'dart:async';

import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class TelephonyService {
  static Telephony telephony = Telephony.instance;

  static Future<bool?> askForPermission() async {
    return await telephony.requestPhoneAndSmsPermissions;
  }

  static getInboxSms() async {
    List sms = await telephony.getInboxSms();
    for (int i = 0; i < sms.length; i++) {
      if (sms[i].address == 'SyriatelSEP') {
        debugPrint(sms[i].body);
      }
    }
  }

  static void listenForIncomingSms() {
    telephony.listenIncomingSms(
      listenInBackground: false,
      onNewMessage: (SmsMessage message) {
        if (message.address == 'SyriatelSEP') {
          debugPrint(message.body);
        }

        //print('Received SMS : ${message.body.toString()}');

        // we will pass the body of message here based on contact address
      },
    );
  }
}

void onBackgroundMessage(SmsMessage message) async {
// same code  for listener ...
  debugPrint("Received SMS on background: ${message.body}");
}
