import 'package:organize_me/database/db.dart';
import 'package:sqflite/sqflite.dart';

class TelecomBill {
  int id;
  double paymentAmount;
  double commissionAmount;
  String invoiceNumber;
  String date;
  String phoneNumberEmail;
  String operationNumber;
  TelecomBill({
    required this.id,
    required this.paymentAmount,
    required this.commissionAmount,
    required this.date,
    required this.phoneNumberEmail,
    required this.invoiceNumber,
    required this.operationNumber,
  });
  static TelecomBill fromMap(Map elBillMap) {
    return TelecomBill(
      id: elBillMap['id'],
      commissionAmount: elBillMap['commission_amount'],
      date: elBillMap['date'],
      phoneNumberEmail: elBillMap['phone_number_email'],
      invoiceNumber: elBillMap['invoice_number'],
      operationNumber: elBillMap['operation_number'],
      paymentAmount: elBillMap['payment_amount'],
    );
  }

  static Future<Map> addTelBill(
    double paymentAmount,
    double commissionAmount,
    String invoiceNumber,
    String date,
    String phoneNumberEmail,
    String operationNumber,
  ) async {
    Database? mydb = await DatabaseHelper.db;
    int billId = await mydb!.rawInsert(
      """
        INSERT OR IGNORE INTO telecom_bills(
          payment_amount,
          commission_amount,
          invoice_number,
          date,
          phone_number_email,
          operation_number
        ) VALUES (?, ?, ?, ?, ?, ?);
      """,
      [
        paymentAmount,
        commissionAmount,
        invoiceNumber,
        date,
        phoneNumberEmail,
        operationNumber,
      ],
    );
    return (await geOneTelBill(billId));
  }

  // static Future<Map> editTelBill(
  //   int billId,
  // ) async {
  //   Database? mydb = await DatabaseHelper.db;
  //   // String editName = newName.isNotEmpty ? "name = '$newName'" : "";
  //   await mydb!.rawUpdate(
  //     """
  //       UPDATE telecom_bills SET    WHERE id = ?;
  //     """,
  //     [
  //       billId,
  //     ],
  //   );
  //   return geOneTelBill(billId);
  // }

  static deleteTelBill(int billId) async {
    Database? mydb = await DatabaseHelper.db;
    await mydb!.rawDelete(
      """
        DELETE FROM telecom_bills WHERE id = ?;
      """,
      [
        billId,
      ],
    );
  }

  static Future<Map> geOneTelBill(int billId) async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> bill = await mydb!.rawQuery(
      """
        SELECT * FROM telecom_bills WHERE id = ?
      """,
      [
        billId,
      ],
    );

    return bill[0];
  }

  static Future<List<TelecomBill>> getAllTelBills() async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> telBillsMap = await mydb!.rawQuery(
      """
        SELECT * FROM telecom_bills;
      """,
    );
    List<TelecomBill> bills = [];
    for (Map bill in telBillsMap) {
      bills.add(TelecomBill.fromMap(bill));
    }
    return bills;
  }
}
