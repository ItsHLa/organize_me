import 'package:organize_me/database/db.dart';
import 'package:sqflite/sqflite.dart';

class ElectricBill {
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
    double paymentAmount,
    double commissionAmount,
    String invoiceNumber,
    String date,
    String gov,
    String billingNumber,
    String subscriptionNumber,
    String operationNumber,
  ) async {
    Database? mydb = await DatabaseHelper.db;
    int billId = await mydb!.rawInsert(
      """
        INSERT OR IGNORE INTO electric_bills(
          payment_amount,
          commission_amount,
          date,
          gov,
          billing_number,
          invoice_number,
          operation_number,
          subscription_number
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?);
      """,
      [
        paymentAmount,
        commissionAmount,
        date,
        gov,
        billingNumber,
        invoiceNumber,
        operationNumber,
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
}
