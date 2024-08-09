import 'package:organize_me/database/db.dart';
import 'package:sqflite/sqflite.dart';

class DoctorsContacts {
  static const String tableName = "doctors_contacts";
  final int id;
  final String name;
  final String phone;
  final String specialist;
  final String clinicPhone;

  const DoctorsContacts({
    required this.id,
    required this.name,
    required this.phone,
    required this.clinicPhone,
    required this.specialist,
  });

  static DoctorsContacts fromMap(Map docConMap) {
    return DoctorsContacts(
      id: docConMap['id'],
      name: docConMap['name'],
      phone: docConMap['phone'],
      clinicPhone: docConMap['clinic_number'],
      specialist: docConMap['specialist'],
    );
  }

  static Future<Map> addContact(
      String name, String phone, String clinic, String specialist) async {
    Database? mydb = await DatabaseHelper.db;
    int contactId = await mydb!.insert(
      tableName,
      {
        "name": name,
        "phone": phone,
        "clinic_number": clinic,
        "specialist": specialist,
      },
    );
    return (await geOneContact(contactId));
  }

  static Future<Map> editContact(
    int contactId, {
    String newPhone = '',
    String newClinicNumber = '',
  }) async {
    Database? mydb = await DatabaseHelper.db;
    Map<String, Object> values = {};
    if (newClinicNumber.isNotEmpty) values['clinic_number'] = newClinicNumber;
    if (newPhone.isNotEmpty) values['phone'] = newPhone;
    await mydb!.update(
      tableName,
      values,
      where: "id = ?",
      whereArgs: [contactId],
    );
    return geOneContact(contactId);
  }

  static deleteContact(int contactId) async {
    Database? mydb = await DatabaseHelper.db;
    await mydb!.delete(
      tableName,
      where: "id = ?",
      whereArgs: [contactId],
    );
  }

  static Future<Map> geOneContact(int contactId) async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> contact = await mydb!.query(
      tableName,
      where: "id = ?",
      whereArgs: [contactId],
    );

    return contact[0];
  }

  static Future<List<DoctorsContacts>> getAllContacts() async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> contactssMap = await mydb!.query(tableName);
    List<DoctorsContacts> contacts = [];
    for (Map contact in contactssMap) {
      contacts.add(fromMap(contact));
    }
    return contacts;
  }
}
