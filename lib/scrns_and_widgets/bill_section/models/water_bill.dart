import 'package:organize_me/constants.dart';
import 'package:organize_me/database/db.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/bill.dart';
import 'package:organize_me/services/api_calls.dart';
import 'package:organize_me/services/functionality.dart';
import 'package:sqflite/sqflite.dart';

class WaterBill extends Bill {
  static const String tableName = 'water_bills';
  int id;
  double paymentAmount;
  double commissionAmount;
  String date;
  String time;
  String provider;
  String operationNumber;
  String gov;
  String receiptNumber;
  String barcodeNumber;
  String counterNumber;
  WaterBill({
    required this.id,
    required this.paymentAmount,
    required this.commissionAmount,
    required this.date,
    required this.time,
    required this.provider,
    required this.operationNumber,
    required this.gov,
    required this.receiptNumber,
    required this.barcodeNumber,
    required this.counterNumber,
  });
  static WaterBill fromMap(Map elBillMap) => WaterBill(
        id: elBillMap['id'],
        paymentAmount: elBillMap['payment_amount'],
        commissionAmount: elBillMap['commission_amount'],
        date: elBillMap['date'],
        time: elBillMap['time'],
        provider: elBillMap['provider'],
        gov: elBillMap['gov'],
        receiptNumber: elBillMap['receipt_number'],
        barcodeNumber: elBillMap['barcode_number'],
        counterNumber: elBillMap['counter_number'],
        operationNumber: elBillMap['operation_number'],
      );

  static Map _extractMatches(Match match) {
    Map matchesMap = {};
    matchesMap['payment_amount'] =
        double.parse(match.group(waterRegexGroups['payment amount']!)!);

    matchesMap['commission_amount'] =
        double.parse(match.group(waterRegexGroups['commission amount']!)!);

    matchesMap['operation_number'] =
        match.group(waterRegexGroups['operation number']!)!;

    matchesMap['receipt_number'] =
        match.group(waterRegexGroups['receipt number']!)!;

    matchesMap['barcode_number'] =
        match.group(waterRegexGroups['barcode number']!)!;

    matchesMap['counter_number'] =
        match.group(waterRegexGroups['counter number']!)!;

    String dateTime = match.group(waterRegexGroups['date']!)!;
    matchesMap['date'] = dateTime
        .split(' ')[0]
        .replaceAll('/', '-')
        .split('-')
        .swap(0, 2)
        .join('-');
    matchesMap['time'] = '${dateTime.split(' ')[1]}:00';

    matchesMap['gov'] = match.group(waterRegexGroups['gov']!)!;
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

          gov,

          receipt_number,
          barcode_number,
          counter_number

        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
      """,
      [
        matchesMap['payment_amount'],
        matchesMap['commission_amount'],
        matchesMap['date'],
        matchesMap['time'],
        provider,
        matchesMap['operation_number'],
        matchesMap['gov'],
        matchesMap['receipt_number'],
        matchesMap['barcode_number'],
        matchesMap['counter_number'],
      ],
    );
    WaterBill bill = WaterBill(
      id: billId,
      paymentAmount: matchesMap['payment_amount'],
      commissionAmount: matchesMap['commission_amount'],
      date: matchesMap['date'],
      time: matchesMap['time'],
      provider: provider,
      operationNumber: matchesMap['operation_number'],
      gov: matchesMap['gov'],
      receiptNumber: matchesMap['receipt_number'],
      barcodeNumber: matchesMap['barcode_number'],
      counterNumber: matchesMap['counter_number'],
    );
    // TODO We need to check the internet first

    await ApiCalls.addBill(me.id, 'wa', bill);
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

  static Future<List<WaterBill>> getAllBills() async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> waBillsMap = await mydb!.rawQuery(
      """
        SELECT * FROM $tableName;
      """,
    );
    List<WaterBill> bills = [];
    for (Map bill in waBillsMap) {
      bills.add(WaterBill.fromMap(bill));
    }
    return bills;
  }

  static Future<List<WaterBill>> getBillsFromId(int id) async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> elBillsMap = await mydb!.rawQuery(
      """
        SELECT * FROM $tableName WHERE id > ?;
      """,
      [id],
    );
    List<WaterBill> bills = [];
    for (Map bill in elBillsMap) {
      bills.add(WaterBill.fromMap(bill));
    }
    return bills;
  }

  factory WaterBill.fromJson(Map<String, dynamic> json) => WaterBill(
        id: json["id"],
        paymentAmount: json["payment_amount"],
        commissionAmount: json["commission_amount"],
        date: json["date"],
        time: json["time"],
        provider: json["provider"],
        operationNumber: json["operation_number"],
        gov: json["gov"],
        receiptNumber: json["receipt_number"],
        barcodeNumber: json["barcode_number"],
        counterNumber: json["counter_number"],
      );

  @override
  Map<String, String> toJson() => {
        "payment_amount": paymentAmount.toString(),
        "commission_amount": commissionAmount.toString(),
        "date": date,
        "time": time,
        "provider": provider,
        "operation_number": operationNumber,
        "gov": gov,
        "receipt_number": receiptNumber,
        "counter_number": counterNumber,
        "barcode_number": barcodeNumber,
      };
}
