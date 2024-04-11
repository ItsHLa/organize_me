import 'package:telephony/telephony.dart';

class TelephonyService {
  static Telephony telephony = Telephony.instance;

  static Future<bool?> askForPermission() async {
    return await telephony.requestPhoneAndSmsPermissions;
  }

  static backgrounMessageHandler(SmsMessage message) async {
    if (message.body!.contains('تم دفع مبلغ')) {
      print(
          '${message.body}+++++++++++++++++++++++++++++++++++++++++++++++++++');
    }
    //Handle background message
    // You can also call other plugin in here
  }

  static listenForIncomingSms() {
    telephony.listenIncomingSms(
        onNewMessage: (message) {
          if (message.address == 'SyriatelSEP') {
            print(' reg is being used here ++++++++++');
          }
        },
        listenInBackground: true,
        onBackgroundMessage: backgrounMessageHandler);
  }
}
