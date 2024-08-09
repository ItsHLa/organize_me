import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/bill.dart';
import 'package:organize_me/services/functionality.dart';

class TelecomBill extends Bill {
  static const tableName = 'telecom_bills';
  static const tempTableName = 'temp_telecom_bills';

  String phoneNumberEmail;
  String invoiceNumber;
  TelecomBill({
    super.id,
    required super.paymentAmount,
    required super.commissionAmount,
    required super.date,
    required super.time,
    required super.provider,
    required super.operationNumber,
    required this.phoneNumberEmail,
    required this.invoiceNumber,
  });
  static TelecomBill fromMap(Map telBillMap) {
    return TelecomBill(
      id: telBillMap['id'],
      paymentAmount: telBillMap['payment_amount'],
      commissionAmount: telBillMap['commission_amount'],
      date: telBillMap['date'],
      time: telBillMap['time'],
      provider: telBillMap['provider'],
      operationNumber: telBillMap['operation_number'],
      phoneNumberEmail: telBillMap['phone_number_email'],
      invoiceNumber: telBillMap['invoice_number'],
    );
  }

  static Map<String, Object?> extractMatches(Match match) {
    Map<String, Object?> matchesMap = {};
    matchesMap['payment_amount'] =
        double.parse(match.group(telecomRegexGroups['payment amount']!)!);

    matchesMap['commission_amount'] =
        double.parse(match.group(telecomRegexGroups['commission amount']!)!);

    matchesMap['operation_number'] =
        match.group(telecomRegexGroups['operation number']!)!;

    matchesMap['phone_number_email'] =
        match.group(telecomRegexGroups['phone number/email']!)!;

    matchesMap['invoice_number'] =
        match.group(telecomRegexGroups['invoice number']!)!;

    String dateTime = match.group(telecomRegexGroups['date']!)!;
    matchesMap['date'] = dateTime
        .split(' ')[0]
        .replaceAll('/', '-')
        .split('-')
        .swap(0, 2)
        .join('-');
    matchesMap['time'] = '${dateTime.split(' ')[1]}:00';
    return matchesMap;
  }

  @override
  Map<String, String> toJson() => {
        "payment_amount": paymentAmount.toString(),
        "commission_amount": commissionAmount.toString(),
        "date": date,
        "time": time,
        "provider": provider,
        "operation_number": operationNumber,
        "phone_number_email": phoneNumberEmail,
        "invoice_number": invoiceNumber,
      };
}
