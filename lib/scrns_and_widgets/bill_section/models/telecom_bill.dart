import 'package:organize_me/constants.dart';
import 'package:organize_me/database/db.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/bill.dart';
import 'package:sqflite/sqflite.dart';

class TelecomBill extends Bill {
  static const tableName = 'telecom_bills';
  int id;
  double paymentAmount;
  double commissionAmount;
  String date;
  String time;
  String provider;
  String operationNumber;
  String phoneNumberEmail;
  String invoiceNumber;
  TelecomBill({
    required this.id,
    required this.paymentAmount,
    required this.commissionAmount,
    required this.date,
    required this.time,
    required this.provider,
    required this.operationNumber,
    required this.phoneNumberEmail,
    required this.invoiceNumber,
  });
  static TelecomBill fromMap(Map telBillMap) {
    return TelecomBill(
      id: telBillMap['id'],
      paymentAmount: telBillMap['payment_amount'],
      commissionAmount: telBillMap['commission_amount'],
      date: telBillMap['date'],
      time: telBillMap['time'],
      provider: telBillMap['provider'],
      operationNumber: telBillMap['operation_number'],
      phoneNumberEmail: telBillMap['phone_number_email'],
      invoiceNumber: telBillMap['invoice_number'],
    );
  }

  static Map _extractMatches(Match match) {
    Map matchesMap = {};
    matchesMap['paymentAmount'] =
        double.parse(match.group(telecomRegexGroups['payment amount']!)!);

    matchesMap['commissionAmount'] =
        double.parse(match.group(telecomRegexGroups['commission amount']!)!);

    matchesMap['operationNumber'] =
        match.group(telecomRegexGroups['operation number']!)!;

    matchesMap['phoneNumberEmail'] =
        match.group(telecomRegexGroups['phone number/email']!)!;

    matchesMap['invoiceNumber'] =
        match.group(telecomRegexGroups['invoice number']!)!;

    String dateTime = match.group(telecomRegexGroups['date']!)!;
    matchesMap['date'] = dateTime.split(' ')[0];
    matchesMap['time'] = dateTime.split(' ')[1];
    return matchesMap;
  }

  static Future<Map> addBill(
    Match match, {
    required String provider,
  }) async {
    Database? mydb = await DatabaseHelper.db;
    Map matchesMap = _extractMatches(match);
    int billId = await mydb!.rawInsert(
      """
        INSERT OR IGNORE INTO $tableName(
          payment_amount,
          commission_amount,
          date,
          time,
          provider,
          operation_number,

          invoice_number,
          phone_number_email

        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?);
      """,
      [
        matchesMap['paymentAmount'],
        matchesMap['commissionAmount'],
        matchesMap['date'],
        matchesMap['time'],
        provider,
        matchesMap['operationNumber'],
        matchesMap['invoiceNumber'],
        matchesMap['phoneNumberEmail'],
      ],
    );
    return (await geOneBill(billId));
  }

  static deleteBill(int billId) async {
    await Bill.deleteBill(tableName, billId);
  }

  static Future<Map> geOneBill(int billId) async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> bill = await mydb!.rawQuery(
      """
        SELECT * FROM $tableName WHERE id = ?
      """,
      [
        billId,
      ],
    );

    return bill[0];
  }

  static Future<List<TelecomBill>> getAllBills() async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> telBillsMap = await mydb!.rawQuery(
      """
        SELECT * FROM $tableName;
      """,
    );
    List<TelecomBill> bills = [];
    for (Map bill in telBillsMap) {
      bills.add(TelecomBill.fromMap(bill));
    }
    return bills;
  }

  factory TelecomBill.fromJson(Map<String, dynamic> json) => TelecomBill(
      id: json["id"],
      paymentAmount: json["paymentAmount"],
      commissionAmount: json["commissionAmount"],
      date: json["date"],
      time: json["time"],
      provider: json["provider"],
      operationNumber: json["operationNumber"],
      invoiceNumber: json["invoiceNumber"],
      phoneNumberEmail: json['phoneNumberEmail']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "paymentAmount": paymentAmount,
        "commissionAmount": commissionAmount,
        "date": date,
        "time": time,
        "provider": provider,
        "operationNumber": operationNumber,
        "phoneNumberEmail": phoneNumberEmail,
        "invoiceNumber": invoiceNumber,
      };
}
