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
          compareBill(smsMessage: message);
        }
      },
    );
  }
}

void onBackgroundMessage(SmsMessage message) async {
  if (message.address == 'SyriatelSEP') {
    debugPrint(message.body);
    compareBill(smsMessage: message);
  }
}

void compareBill({required SmsMessage smsMessage}) {
  String body = smsMessage.body!;
  if (waterRegex.hasMatch(body)) {
    Match match = waterRegex.firstMatch(body)!;
    WaterBill.addBill(match: match, provider: smsMessage.address!);
  } else if (telecomRegex.hasMatch(body)) {
    Match match = telecomRegex.firstMatch(body)!;
    TelecomBill.addBill(match: match, provider: smsMessage.address!);
  } else if (electricRegex.hasMatch(body)) {
    Match match = electricRegex.firstMatch(body)!;
    ElectricBill.addBill(match: match, provider: smsMessage.address!);
  }
}
