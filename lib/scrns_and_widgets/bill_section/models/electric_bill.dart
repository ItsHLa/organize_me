import 'package:organize_me/constants.dart';
import 'package:organize_me/database/db.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/bill.dart';
import 'package:sqflite/sqflite.dart';

class ElectricBill extends Bill {
  static const String tableName = 'electric_bills';
  int id;
  double paymentAmount;
  double commissionAmount;
  String date;
  String time;
  String provider;
  String gov;
  String operationNumber;
  String billingNumber;
  String invoiceNumber;
  String subscriptionNumber;
  ElectricBill({
    required this.id,
    required this.paymentAmount,
    required this.commissionAmount,
    required this.date,
    required this.time,
    required this.provider,
    required this.operationNumber,
    required this.gov,
    required this.billingNumber,
    required this.invoiceNumber,
    required this.subscriptionNumber,
  });

  static ElectricBill fromMap(Map elBillMap) {
    return ElectricBill(
      id: elBillMap['id'],
      paymentAmount: elBillMap['payment_amount'],
      commissionAmount: elBillMap['commission_amount'],
      date: elBillMap['date'],
      time: elBillMap['time'],
      provider: elBillMap['provider'],
      operationNumber: elBillMap['operation_number'],
      gov: elBillMap['gov'],
      billingNumber: elBillMap['billing_number'],
      invoiceNumber: elBillMap['invoice_number'],
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
      paymentAmount: json["paymentAmount"],
      commissionAmount: json["commissionAmount"],
      date: json["date"],
      time: json["time"],
      provider: json["provider"],
      operationNumber: json["operationNumber"],
      gov: json["gov"],
      billingNumber: json["billingNumber"],
      invoiceNumber: json["invoiceNumber"],
      subscriptionNumber: json["subscriptionNumber"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "paymentAmount": paymentAmount,
        "commissionAmount": commissionAmount,
        "date": date,
        "time": time,
        "provider": provider,
        "operationNumber": operationNumber,
        "gov": gov,
        "billingNumber": billingNumber,
        "invoiceNumber": invoiceNumber,
        "subscriptionNumber": subscriptionNumber,
      };
}
