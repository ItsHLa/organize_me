import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/bill.dart';
import 'package:organize_me/services/functionality.dart';

class WaterBill extends Bill {
  static const String tableName = 'water_bills';
  static const String tempTableName = 'temp_water_bills';

  String gov;
  String receiptNumber;
  String barcodeNumber;
  String counterNumber;
  WaterBill({
    super.id,
    required super.paymentAmount,
    required super.commissionAmount,
    required super.date,
    required super.time,
    required super.provider,
    required super.operationNumber,
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

  static Map<String, Object?> extractMatches(Match match) {
    Map<String, Object?> matchesMap = {};
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
