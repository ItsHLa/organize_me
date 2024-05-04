import 'package:organize_me/constants.dart';
import 'package:organize_me/database/db.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/bill.dart';
import 'package:sqflite/sqflite.dart';

class ElectricBill extends Bill {
  int id;
  double paymentAmount;
  double commissionAmount;
  String invoiceNumber;
  String date;
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
      gov: elBillMap['gov'],
      invoiceNumber: elBillMap['invoice_number'],
      operationNumber: elBillMap['operation_number'],
      paymentAmount: elBillMap['payment_amount'],
      subscriptionNumber: elBillMap['subscription_number'],
    );
  }

  static Future<Map> addElBill(
    Match match, {
    required String provider,
  }) async {
    Database? mydb = await DatabaseHelper.db;

    double paymentAmount =
        double.parse(match.group(electricRegexGroups['payment amount']!)!);

    double commissionAmount =
        double.parse(match.group(electricRegexGroups['commission amount']!)!);

    String operationNumber =
        match.group(electricRegexGroups['operation number']!)!;

    String subscriptionNumber =
        match.group(electricRegexGroups['subscription number']!)!;

    String billingNumber = match.group(electricRegexGroups['billing number']!)!;

    String invoiceNumber = match.group(electricRegexGroups['invoice number']!)!;

    String date = match.group(electricRegexGroups['date']!)!;

    String gov = match.group(electricRegexGroups['gov']!)!;

    int billId = await mydb!.rawInsert(
      """
        INSERT OR IGNORE INTO electric_bills(
          payment_amount,
          commission_amount,
          date,
          provider,
          subscription_number,

          gov,

          billing_number,
          invoice_number,
          operation_number

        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);
      """,
      [
        paymentAmount,
        commissionAmount,
        date,
        provider,
        operationNumber,
        gov,
        billingNumber,
        invoiceNumber,
        subscriptionNumber,
      ],
    );
    return (await geOneElBill(billId));
  }

  // static Future<Map> editElBill(
  //   int billId,
  // ) async {
  //   Database? mydb = await DatabaseHelper.db;
  //   // String editName = newName.isNotEmpty ? "name = '$newName'" : "";
  //   await mydb!.rawUpdate(
  //     """
  //       UPDATE electric_bills SET    WHERE id = ?;
  //     """,
  //     [
  //       billId,
  //     ],
  //   );
  //   return geOneElBill(billId);
  // }

  static deleteElBill(int billId) async {
    Database? mydb = await DatabaseHelper.db;
    await mydb!.rawDelete(
      """
        DELETE FROM electric_bills WHERE id = ?;
      """,
      [
        billId,
      ],
    );
  }

  static Future<Map> geOneElBill(int billId) async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> bill = await mydb!.rawQuery(
      """
        SELECT * FROM electric_bills WHERE id = ?
      """,
      [
        billId,
      ],
    );

    return bill[0];
  }

  static Future<List<ElectricBill>> getAllElBills() async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> elBillsMap = await mydb!.rawQuery(
      """
        SELECT * FROM electric_bills;
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
