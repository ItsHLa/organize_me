import 'dart:async';

import 'package:telephony/telephony.dart';

class TelephonyService {
  static Telephony telephony = Telephony.instance;

  static Future<bool?> askForPermission() async {
    return await telephony.requestPhoneAndSmsPermissions;
  }

  static void listenForIncomingSms() {
    void startSmsListener() {
      telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) {
          print('Received SMS : ${message.body}');

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
