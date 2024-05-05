import 'package:organize_me/constants.dart';
import 'package:organize_me/database/db.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/bill.dart';
import 'package:sqflite/sqflite.dart';

class ElectricBill extends Bill {
  static const String tableName = 'electric_bills';
  int id;
  double paymentAmount;
  double commissionAmount;
  String invoiceNumber;
  String date;
  String time;
  String gov;
  String billingNumber;
  String subscriptionNumber;
  String operationNumber;
  ElectricBill({
    required this.id,
    required this.paymentAmount,
    required this.billingNumber,
    required this.commissionAmount,
    required this.date,
    required this.time,
    required this.gov,
    required this.invoiceNumber,
    required this.operationNumber,
    required this.subscriptionNumber,
  });

  static ElectricBill fromMap(Map elBillMap) {
    return ElectricBill(
      id: elBillMap['id'],
      billingNumber: elBillMap['billing_number'],
      commissionAmount: elBillMap['commission_amount'],
      date: elBillMap['date'],
      time: elBillMap['time'],
      gov: elBillMap['gov'],
      invoiceNumber: elBillMap['invoice_number'],
      operationNumber: elBillMap['operation_number'],
      paymentAmount: elBillMap['payment_amount'],
      subscriptionNumber: elBillMap['subscription_number'],
    );
  }

  static Map _extractMatches(Match match) {
    Map matchesMap = {};
    matchesMap['paymentAmount'] =
        double.parse(match.group(electricRegexGroups['payment amount']!)!);

    matchesMap['commissionAmount'] =
        double.parse(match.group(electricRegexGroups['commission amount']!)!);

    matchesMap['operationNumber'] =
        match.group(electricRegexGroups['operation number']!)!;

    matchesMap['subscriptionNumber'] =
        match.group(electricRegexGroups['subscription number']!)!;

    matchesMap['billingNumber'] =
        match.group(electricRegexGroups['billing number']!)!;

    matchesMap['invoiceNumber'] =
        match.group(electricRegexGroups['invoice number']!)!;

    String dateTime = match.group(electricRegexGroups['date']!)!;
    matchesMap['date'] = dateTime.split(' ')[0];
    matchesMap['time'] = dateTime.split(' ')[1];

    matchesMap['gov'] = match.group(electricRegexGroups['gov']!)!;
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
          subscription_number,

          gov,

          billing_number,
          invoice_number,
          operation_number

        ) VALUES (?, ?, ?, ?, ?, ?, ?,s ?, ?, ?);
      """,
      [
        matchesMap['paymentAmount'],
        matchesMap['commissionAmount'],
        matchesMap['date'],
        matchesMap['time'],
        provider,
        matchesMap['operationNumber'],
        matchesMap['gov'],
        matchesMap['billingNumber'],
        matchesMap['invoiceNumber'],
        matchesMap['subscriptionNumber'],
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

  static Future<List<ElectricBill>> getAllBills() async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> elBillsMap = await mydb!.rawQuery(
      """
        SELECT * FROM $tableName;
      """,
    );
    List<ElectricBill> bills = [];
    for (Map bill in elBillsMap) {
      bills.add(ElectricBill.fromMap(bill));
    }
    return bills;
  }

  // TODO search filter methods...
  // (;_;) *crying*

  factory ElectricBill.fromJson(Map<String, dynamic> json) => ElectricBill(
      id: json["id"],
      date: json["date"],
      billingNumber: json["billingNumber"],
      commissionAmount: json["commissionAmount"],
      gov: json["gov"],
      invoiceNumber: json["invoiceNumber"],
      operationNumber: json["operationNumber"],
      paymentAmount: json["paymentAmount"],
      subscriptionNumber: json["subscriptionNumber"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "billingNumber": billingNumber,
        "commissionAmount": commissionAmount,
        "gov": gov,
        "invoiceNumber": invoiceNumber,
        "operationNumber": operationNumber,
        "paymentAmount": paymentAmount,
        "subscriptionNumber": subscriptionNumber
      };
}
