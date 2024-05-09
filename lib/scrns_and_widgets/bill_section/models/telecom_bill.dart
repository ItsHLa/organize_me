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
    matchesMap['payment_amount'] =
        double.parse(match.group(telecomRegexGroups['payment amount']!)!);

    matchesMap['commission_amount'] =
        double.parse(match.group(telecomRegexGroups['commission amount']!)!);

    matchesMap['operation_number'] =
        match.group(telecomRegexGroups['operation number']!)!;

    matchesMap['phone_number_email'] =
        match.group(telecomRegexGroups['phone number/email']!)!;

    matchesMap['invoice_number'] =
        match.group(telecomRegexGroups['invoice number']!)!;

    String dateTime = match.group(telecomRegexGroups['date']!)!;
    matchesMap['date'] = dateTime.split(' ')[0];
    matchesMap['time'] = dateTime.split(' ')[1];
    return matchesMap;
  }

  static Future<Map> addBill({
    Match? match,
    Map? billMap,
    required String provider,
  }) async {
    Database? mydb = await DatabaseHelper.db;

    Map matchesMap;
    if (match != null) {
      matchesMap = _extractMatches(match);
    } else {
      matchesMap = billMap!;
    }

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
        matchesMap['payment_amount'],
        matchesMap['commission_amount'],
        matchesMap['date'],
        matchesMap['time'],
        provider,
        matchesMap['operation_number'],
        matchesMap['invoice_number'],
        matchesMap['phone_number_email'],
      ],
    );
    return match != null ? (await getOneBill(billId)) : {};
  }

  static deleteBill(int billId) async {
    await Bill.deleteBill(tableName, billId);
  }

  static Future<Map> getOneBill(int billId) async {
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
      paymentAmount: json["payment_amount"],
      commissionAmount: json["commission_amount"],
      date: json["date"],
      time: json["time"],
      provider: json["provider"],
      operationNumber: json["operation_number"],
      invoiceNumber: json["invoice_number"],
      phoneNumberEmail: json['phone_number_email']);

  @override
  Map<String, String> toJson() => {
        "payment_amount": paymentAmount.toString(),
        "commission_amount": commissionAmount.toString(),
        "date": date,
        "time": time,
        "provider": provider,
        "operation_number": operationNumber,
        "phone_number_email": phoneNumberEmail,
        "invoice_number": invoiceNumber,
      };
}
