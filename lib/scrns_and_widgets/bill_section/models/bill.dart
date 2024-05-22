import 'dart:developer';

import 'package:organize_me/database/db.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/electric_bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/telecom_bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/water_bill.dart';
import 'package:sqflite/sqflite.dart';

abstract class Bill {
  Map<String, String> toJson();

  static Future<void> fillDatabase({
    required List elBills,
    required List waBills,
    required List telBills,
  }) async {
    for (Map bill in elBills) {
      await ElectricBill.addBill(provider: bill['provider'], billMap: bill);
    }
    for (Map bill in waBills) {
      await WaterBill.addBill(provider: bill['provider'], billMap: bill);
    }
    for (Map bill in telBills) {
      await TelecomBill.addBill(provider: bill['provider'], billMap: bill);
    }
  }

  static Future<double> calculatePayments(
    String tableName,
    String year,
    String month,
  ) async {
    // -- DD/MM/YYYY
    Database? mydb = await DatabaseHelper.db;
    List<Map> payments = [];
    month = month.length == 1 ? '0$month' : month;
    await mydb!.rawQuery(
      """
        SELECT SUM(payment_amount) FROM $tableName 
        WHERE date LIKE '__/$month/$year';
      """,
    ).then((value) {
      payments = value;
    });
    log(payments.toString());
    return payments[0]['SUM(payment_amount)'] ?? 0;
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
