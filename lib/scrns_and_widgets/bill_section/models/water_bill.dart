import 'package:organize_me/database/db.dart';
import 'package:sqflite/sqflite.dart';

class WaterBill {
  int id;
  double paymentAmount;
  double commissionAmount;
  String date;
  String gov;
  String receiptNumber;
  String barcodeNumber;
  String counterNumber;
  String operationNumber;
  WaterBill({
    required this.id,
    required this.paymentAmount,
    required this.receiptNumber,
    required this.commissionAmount,
    required this.date,
    required this.gov,
    required this.barcodeNumber,
    required this.operationNumber,
    required this.counterNumber,
  });
  static WaterBill fromMap(Map elBillMap) {
    return WaterBill(
      id: elBillMap['id'],
      paymentAmount: elBillMap['payment_amount'],
      commissionAmount: elBillMap['commission_amount'],
      date: elBillMap['date'],
      gov: elBillMap['gov'],
      receiptNumber: elBillMap['receipt_number'],
      barcodeNumber: elBillMap['barcode_number'],
      counterNumber: elBillMap['counter_number'],
      operationNumber: elBillMap['operation_number'],
    );
  }

  static Future<Map> addWaBill(
    double paymentAmount,
    double commissionAmount,
    String date,
    String gov,
    String receiptNumber,
    String barcodeNumber,
    String counterNumber,
    String operationNumber,
  ) async {
    Database? mydb = await DatabaseHelper.db;
    int billId = await mydb!.rawInsert(
      """
        INSERT OR IGNORE INTO water_bills(
          payment_amount,
          commission_amount,
          date,
          gov,
          receipt_number,
          barcode_number,
          counter_number,
          operation_number
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?);
      """,
      [
        paymentAmount,
        commissionAmount,
        date,
        gov,
        receiptNumber,
        barcodeNumber,
        counterNumber,
        operationNumber,
      ],
    );
    return (await geOneWaBill(billId));
  }

  // static Future<Map> editWaBill(
  //   int billId,
  // ) async {
  //   Database? mydb = await DatabaseHelper.db;
  //   // String editName = newName.isNotEmpty ? "name = '$newName'" : "";
  //   await mydb!.rawUpdate(
  //     """
  //       UPDATE water_bills SET    WHERE id = ?;
  //     """,
  //     [
  //       billId,
  //     ],
  //   );
  //   return geOneWaBill(billId);
  // }

  static deleteWaBill(int billId) async {
    Database? mydb = await DatabaseHelper.db;
    await mydb!.rawDelete(
      """
        DELETE FROM water_bills WHERE id = ?;
      """,
      [
        billId,
      ],
    );
  }

  static Future<Map> geOneWaBill(int billId) async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> bill = await mydb!.rawQuery(
      """
        SELECT * FROM water_bills WHERE id = ?
      """,
      [
        billId,
      ],
    );

    return bill[0];
  }

  static Future<List<WaterBill>> getAllWaBills() async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> waBillsMap = await mydb!.rawQuery(
      """
        SELECT * FROM water_bills;
      """,
    );
    List<WaterBill> bills = [];
    for (Map bill in waBillsMap) {
      bills.add(WaterBill.fromMap(bill));
    }
    return bills;
  }
}