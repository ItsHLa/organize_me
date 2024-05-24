import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/database/db.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/electric_bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/telecom_bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/water_bill.dart';
import 'package:organize_me/services/api_calls.dart';
import 'package:sqflite/sqflite.dart';

abstract class Bill {
  int? id;
  double paymentAmount;
  double commissionAmount;
  String date;
  String time;
  String provider;
  String operationNumber;
  Bill({
    required this.id,
    required this.paymentAmount,
    required this.commissionAmount,
    required this.date,
    required this.time,
    required this.provider,
    required this.operationNumber,
  });

  Map<String, String> toJson();

  static Bill fromMap(Map billMap, String tableName) {
    Bill bill;
    switch (tableName) {
      case WaterBill.tempTableName:
      case WaterBill.tableName:
        bill = WaterBill.fromMap(billMap);
        break;
      case ElectricBill.tempTableName:
      case ElectricBill.tableName:
        bill = ElectricBill.fromMap(billMap);
        break;
      case TelecomBill.tempTableName:
      case TelecomBill.tableName:
        bill = TelecomBill.fromMap(billMap);
        break;
      default:
        bill = TelecomBill.fromMap(billMap);
        break;
    }
    return bill;
  }

  static Future<Map> addBill({
    Match? match,
    Map<String, Object?> Function(Match match)? extractMatches,
    Map<String, Object?>? billMap,
    required String provider,
    required String tableName,
    String? tempTableName,
  }) async {
    billMap ??= extractMatches!(match!);
    billMap['provider'] = provider;
    Database? mydb = await DatabaseHelper.db;
    int billId = await mydb!.insert(
      tableName,
      billMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // this check indicates that the bill is new, so we wanna send it (if possible) via an api call.
    if (match != null) {
      var result = await (Connectivity().checkConnectivity());
      // if there's a connection send it via api call right away.
      if (result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile)) {
        await ApiCalls.addBill(me.id, tableNameToTypeCode[tableName]!, billMap);
        // otherwise store it in the temp table.
      } else {
        await mydb.insert(
          tempTableName!,
          billMap,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      return (await getOneBill(billId, tableName));
    }
    return {};
  }

  static Future<Map> getOneBill(int billId, String tableName) async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> bill = await mydb!.query(
      tableName,
      where: "id = ?",
      whereArgs: [billId],
    );
    return bill[0];
  }

  static Future<List<Bill>> getAllBills(String tableName) async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> waBillsMap = await mydb!.query(tableName);
    List<Bill> bills = [];
    for (Map bill in waBillsMap) {
      bills.add(fromMap(bill, tableName));
    }
    return bills;
  }

  static Future<List<Bill>> getAllTempBills(String tempTableName) async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> waBillsMap = await mydb!.query(tempTableName);
    List<Bill> bills = [];
    for (Map bill in waBillsMap) {
      bills.add(fromMap(bill, tempTableName));
    }
    return bills;
  }

  static Future<void> clearTempTable(String tempTableName) async {
    Database? mydb = await DatabaseHelper.db;
    await mydb!.delete(tempTableName);
  }

  static Future<void> fillDatabase({
    required List elBills,
    required List waBills,
    required List telBills,
  }) async {
    Database? mydb = await DatabaseHelper.db;
    Batch batch = mydb!.batch();
    for (Map<String, Object?> bill in elBills) {
      bill.remove('user');
      batch.insert(ElectricBill.tableName, bill,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    for (Map<String, Object?> bill in waBills) {
      bill.remove('user');
      batch.insert(WaterBill.tableName, bill,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    for (Map<String, Object?> bill in telBills) {
      bill.remove('user');
      batch.insert(TelecomBill.tableName, bill,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  static Future<double> calculatePayments(
    String tableName,
    String year,
    String month,
  ) async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> payments = [];
    month = month.length == 1 ? '0$month' : month;
    await mydb!
        .query(tableName,
            columns: ['SUM(payment_amount)'],
            where: "date LIKE '$year-$month-__'")
        .then((value) => payments = value);
    return payments[0]['SUM(payment_amount)'] ?? 0;
  }

  static deleteBill(String tableName, int billId) async {
    Database? mydb = await DatabaseHelper.db;
    await mydb!.delete(tableName, where: "id = ?", whereArgs: [billId]);
  }
}
