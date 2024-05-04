import 'package:organize_me/constants.dart';
import 'package:organize_me/database/db.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/bill.dart';
import 'package:sqflite/sqflite.dart';

class TelecomBill extends Bill {
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
    Match match, {
    required String provider,
  }) async {
    Database? mydb = await DatabaseHelper.db;

    double paymentAmount =
        double.parse(match.group(telecomRegexGroups['payment amount']!)!);

    double commissionAmount =
        double.parse(match.group(telecomRegexGroups['commission amount']!)!);

    String operationNumber =
        match.group(telecomRegexGroups['operation number']!)!;

    String phoneNumberEmail =
        match.group(telecomRegexGroups['phone number/email']!)!;

    String invoiceNumber = match.group(telecomRegexGroups['invoice number']!)!;

    String date = match.group(telecomRegexGroups['date']!)!;

    int billId = await mydb!.rawInsert(
      """
        INSERT OR IGNORE INTO telecom_bills(
          payment_amount,
          commission_amount,
          date,
          provider,
          operation_number,

          invoice_number,
          phone_number_email

        ) VALUES (?, ?, ?, ?, ?, ?, ?);
      """,
      [
        paymentAmount,
        commissionAmount,
        date,
        provider,
        operationNumber,
        invoiceNumber,
        phoneNumberEmail,
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

  factory TelecomBill.fromJson(Map<String, dynamic> json) => TelecomBill(
      id: json["id"],
      date: json["date"],
      commissionAmount: json["commissionAmount"],
      invoiceNumber: json["invoiceNumber"],
      operationNumber: json["operationNumber"],
      paymentAmount: json["paymentAmount"],
      phoneNumberEmail: json['phoneNumberEmail']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "commissionAmount": commissionAmount,
        "invoiceNumber": invoiceNumber,
        "operationNumber": operationNumber,
        "paymentAmount": paymentAmount,
        "phoneNumberEmail": phoneNumberEmail
      };
}
