import 'dart:async';

import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';
import 'package:telephony/telephony.dart';

class TelephonyService {
  static Telephony telephony = Telephony.instance;

  static Future<bool?> askForPermission() async {
    return await telephony.requestPhoneAndSmsPermissions;
  }

  static void listenForIncomingSms() {
    telephony.listenIncomingSms(
      onBackgroundMessage: onBackgroundMessage,
      listenInBackground: true,
      onNewMessage: (SmsMessage message) {
        if (message.address == 'SyriatelSEP') {
          debugPrint(message.body);
          compareBill(smsMessage: message.body!);
        }
        debugPrint('message that is not a bill');
        debugPrint(message.address);
        debugPrint(message.body);

        // we will pass the body of message here based on contact address
      },
    );
  }
}

void onBackgroundMessage(SmsMessage message) async {
// same code  for listener ...

  if (message.address == 'SyriatelSEP') {
    debugPrint(message.body);
    compareBill(smsMessage: message.body!);
  }
  debugPrint('message that is not a bill');
  debugPrint(message.address);
  debugPrint(message.body);
}

void compareBill({required String smsMessage}) {
  if (waterRegex.hasMatch(smsMessage)) {
    debugPrint('${waterRegexGroups}');
  }

  if (telecomRegex.hasMatch(smsMessage)) {
    debugPrint('${telecomRegexGroups}');
  }

  if (electricRegex.hasMatch(smsMessage)) {
    debugPrint('${electricRegexGroups}');
  }
}