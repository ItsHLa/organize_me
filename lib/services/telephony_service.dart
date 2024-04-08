import 'package:telephony/telephony.dart';

class TelephonyService {
  static Telephony telephony = Telephony.instance;

  static Future<bool?> askForPermission() async {
    return await telephony.requestPhoneAndSmsPermissions;
  }

  static Future<List<SmsMessage>> filterWaterInboxMessages() async {
    return await telephony.getInboxSms(
      columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
      filter: SmsFilter.where(SmsColumn.BODY).like('مياه'),
    );
  }

  static Future<List<SmsMessage>> filterCallsInboxMessages() async {
    return await telephony.getInboxSms(
      columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
      filter: SmsFilter.where(SmsColumn.BODY).like('اتصالات'),
    );
  }

  static Future<List<SmsMessage>> filterElectInboxMessages() async {
    return await telephony.getInboxSms(
      columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
      filter: SmsFilter.where(SmsColumn.BODY).like('الكهرباء'),
    );
  }
}
