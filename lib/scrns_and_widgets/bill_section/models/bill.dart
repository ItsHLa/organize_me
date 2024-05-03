import 'package:organize_me/database/db.dart';
import 'package:sqflite/sqflite.dart';

abstract class Bill {
  static Future<double> calculatePayments(
    String tableName,
    int year,
    int month,
  ) async {
    // -- DD/MM/YYYY
    Database? mydb = await DatabaseHelper.db;
    List<Map> payments = await mydb!.rawQuery(
      """
        SELECT SUM(payment_amount) FROM $tableName 
        WHERE date LIKE '__/${month.toString().padLeft(2, '0')}/$year';
      """,
    );

    return payments[0]['SUM(payment_amount)'];
  }

  static deleteBill(String tableName, int billId) async {
    Database? mydb = await DatabaseHelper.db;
    await mydb!.rawDelete(
      """
        DELETE FROM $tableName WHERE id = ?;
      """,
      [
        billId,
      ],
    );
  }
}
