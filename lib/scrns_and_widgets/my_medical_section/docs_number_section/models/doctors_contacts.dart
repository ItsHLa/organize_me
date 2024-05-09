import 'package:organize_me/database/db.dart';
import 'package:sqflite/sqflite.dart';

class DoctorsContacts {
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
        specialist: docConMap['specialist'],
        clinicPhone: docConMap['clinic_number']);
  }

  static Future<Map> addContact(
      String name, String phone, String clinic, String specialist) async {
    Database? mydb = await DatabaseHelper.db;
    int contactId = await mydb!.rawInsert(
      """
        INSERT OR IGNORE INTO doctors_contacts(name, phone , clinic_number, specialist) VALUES (?, ? ,?, ?);
      """,
      [name, phone, clinic, specialist],
    );
    return (await geOneContact(contactId));
  }

  static Future<Map> editContact(int contactId,
      {String newPhone = '',
      String newClinicNumber = '',
      String newName = ''}) async {
    Database? mydb = await DatabaseHelper.db;
    String editName = newName.isNotEmpty ? "name = '$newName'" : "";
    String editPhone = newPhone.isNotEmpty ? "phone = '$newPhone'" : "";
    String editClinicNumber =
        newClinicNumber.isNotEmpty ? "clinic_number = '$newClinicNumber'" : "";
    // editName.isNotEmpty && editPhone.isNotEmpty
    //    ? editPhone += ','
    //   : editPhone += '';
    await mydb!.rawUpdate(
      """
        UPDATE doctors_contacts SET $editPhone , $editName , $editClinicNumber WHERE id = ?;
      """,
      [
        contactId,
      ],
    );
    return geOneContact(contactId);
  }

  static deleteContact(int contactId) async {
    Database? mydb = await DatabaseHelper.db;
    await mydb!.rawDelete(
      """
        DELETE FROM doctors_contacts WHERE id = ?;
      """,
      [
        contactId,
      ],
    );
  }

  static Future<Map> geOneContact(int contactId) async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> contact = await mydb!.rawQuery(
      """
        SELECT * FROM doctors_contacts WHERE id = ?
      """,
      [
        contactId,
      ],
    );

    return contact[0];
  }

  static Future<List<DoctorsContacts>> getAllContacts() async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> contactssMap = await mydb!.rawQuery(
      """
        SELECT * FROM doctors_contacts
      """,
    );
    List<DoctorsContacts> contacts = [];
    for (Map contact in contactssMap) {
      contacts.add(fromMap(contact));
    }
    return contacts;
  }
}
