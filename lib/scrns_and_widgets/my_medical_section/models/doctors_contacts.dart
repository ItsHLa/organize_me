import 'package:organize_me/database/db.dart';
import 'package:sqflite/sqflite.dart';

class DoctorsContacts {
  final int id;
  final String name;
  final String phone;
  const DoctorsContacts({
    required this.id,
    required this.name,
    required this.phone,
  });
  static DoctorsContacts fromMap(Map docConMap) {
    return DoctorsContacts(
      id: docConMap['id'],
      name: docConMap['name'],
      phone: docConMap['phone'],
    );
  }

  static Future<Map> addContact(String name, String phone) async {
    Database? mydb = await DatabaseHelper.db;
    int contactId = await mydb!.rawInsert(
      """
        INSERT OR IGNORE INTO doctors_contacts(name, phone) VALUES (?, ?);
      """,
      [
        name,
        phone,
      ],
    );
    return (await geOneContact(contactId));
  }

  static Future<Map> editContact(int contactId,
      {String newPhone = '', String newName = ''}) async {
    Database? mydb = await DatabaseHelper.db;
    String editName = newName.isNotEmpty ? "name = '$newName'" : "";
    String editPhone = newPhone.isNotEmpty ? "phone = '$newPhone'" : "";
    editName.isNotEmpty && editPhone.isNotEmpty
        ? editPhone += ','
        : editPhone += '';
    await mydb!.rawUpdate(
      """
        UPDATE doctors_contacts SET $editPhone $editName WHERE id = ?;
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
      contacts.add(DoctorsContacts.fromMap(contact));
    }
    return contacts;
  }
}
