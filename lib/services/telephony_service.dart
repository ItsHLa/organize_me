
import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/electric_bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/telecom_bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/water_bill.dart';
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
    Match match = waterRegex.firstMatch(smsMessage)!;
    WaterBill.addWaBill(match);
  } else if (telecomRegex.hasMatch(smsMessage)) {
    Match match = telecomRegex.firstMatch(smsMessage)!;
    TelecomBill.addTelBill(match);
  } else if (electricRegex.hasMatch(smsMessage)) {
    Match match = electricRegex.firstMatch(smsMessage)!;
    ElectricBill.addElBill(match);
  }
}
