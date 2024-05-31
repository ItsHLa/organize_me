import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/bill.dart';
import 'package:organize_me/services/functionality.dart';

class ElectricBill extends Bill {
  static const String tableName = 'electric_bills';
  static const String tempTableName = 'temp_electric_bills';
  String gov;
  String billingNumber;
  String invoiceNumber;
  String subscriptionNumber;
  ElectricBill({
    super.id,
    required super.paymentAmount,
    required super.commissionAmount,
    required super.date,
    required super.time,
    required super.provider,
    required super.operationNumber,
    required this.gov,
    required this.billingNumber,
    required this.invoiceNumber,
    required this.subscriptionNumber,
  });

  static ElectricBill fromMap(Map elBillMap) {
    return ElectricBill(
      id: elBillMap['id'],
      paymentAmount: elBillMap['payment_amount'],
      commissionAmount: elBillMap['commission_amount'],
      date: elBillMap['date'],
      time: elBillMap['time'],
      provider: elBillMap['provider'],
      operationNumber: elBillMap['operation_number'],
      gov: elBillMap['gov'],
      billingNumber: elBillMap['billing_number'],
      invoiceNumber: elBillMap['invoice_number'],
      subscriptionNumber: elBillMap['subscription_number'],
    );
  }

  static Map<String, Object?> extractMatches(Match match) {
    Map<String, Object?> matchesMap = {};
    matchesMap['payment_amount'] =
        double.parse(match.group(electricRegexGroups['payment amount']!)!);

    matchesMap['commission_amount'] =
        double.parse(match.group(electricRegexGroups['commission amount']!)!);

    matchesMap['operation_number'] =
        match.group(electricRegexGroups['operation number']!)!;

    matchesMap['subscription_number'] =
        match.group(electricRegexGroups['subscription number']!)!;

    matchesMap['billing_number'] =
        match.group(electricRegexGroups['billing number']!)!;

    matchesMap['invoice_number'] =
        match.group(electricRegexGroups['invoice number']!)!;

    String dateTime = match.group(electricRegexGroups['date']!)!;
    matchesMap['date'] = dateTime
        .split(' ')[0]
        .replaceAll('/', '-')
        .split('-')
        .swap(0, 2)
        .join('-');
    matchesMap['time'] = '${dateTime.split(' ')[1]}:00';

    matchesMap['gov'] = match.group(electricRegexGroups['gov']!)!;
    return matchesMap;
  }

  factory ElectricBill.fromJson(Map<String, dynamic> json) => ElectricBill(
        id: json["id"],
        paymentAmount: json["payment_amount"],
        commissionAmount: json["commission_amount"],
        date: json["date"],
        time: json["time"],
        provider: json["provider"],
        operationNumber: json["operation_number"],
        gov: json["gov"],
        billingNumber: json["billing_number"],
        invoiceNumber: json["invoice_number"],
        subscriptionNumber: json["subscription_number"],
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
        "billing_number": billingNumber,
        "invoice_number": invoiceNumber,
        "subscription_number": subscriptionNumber,
      };
}
