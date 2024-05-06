import 'package:organize_me/constants.dart';
import 'package:organize_me/database/db.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/bill.dart';
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
    matchesMap['paymentAmount'] =
        double.parse(match.group(waterRegexGroups['payment amount']!)!);

    matchesMap['commissionAmount'] =
        double.parse(match.group(waterRegexGroups['commission amount']!)!);

    matchesMap['operationNumber'] =
        match.group(waterRegexGroups['operation number']!)!;

    matchesMap['receiptNumber'] =
        match.group(waterRegexGroups['receipt number']!)!;

    matchesMap['barcodeNumber'] =
        match.group(waterRegexGroups['barcode number']!)!;

    matchesMap['counterNumber'] =
        match.group(waterRegexGroups['counter number']!)!;

    String dateTime = match.group(waterRegexGroups['date']!)!;
    matchesMap['date'] = dateTime.split(' ')[0];
    matchesMap['time'] = dateTime.split(' ')[1];

    matchesMap['gov'] = match.group(waterRegexGroups['gov']!)!;
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
          operation_number,

          gov,

          receipt_number,
          barcode_number,
          counter_number

        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
      """,
      [
        matchesMap['paymentAmount'],
        matchesMap['commissionAmount'],
        matchesMap['date'],
        matchesMap['time'],
        provider,
        matchesMap['operationNumber'],
        matchesMap['gov'],
        matchesMap['receiptNumber'],
        matchesMap['barcodeNumber'],
        matchesMap['counterNumber'],
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

  factory WaterBill.fromJson(Map<String, dynamic> json) => WaterBill(
        id: json["id"],
        paymentAmount: json["paymentAmount"],
        commissionAmount: json["commissionAmount"],
        date: json["date"],
        time: json["time"],
        provider: json["provider"],
        operationNumber: json["operationNumber"],
        gov: json["gov"],
        receiptNumber: json["receiptNumber"],
        barcodeNumber: json["barcodeNumber"],
        counterNumber: json["counterNumber"],
      );

  @override
  Map<String, String> toJson() => {
        "paymentAmount": paymentAmount.toString(),
        "commissionAmount": commissionAmount.toString(),
        "date": date,
        "time": time,
        "provider": provider,
        "operationNumber": operationNumber,
        "gov": gov,
        "receiptNumber": receiptNumber,
        "counterNumber": counterNumber,
        "barcodeNumber": barcodeNumber,
      };
}
