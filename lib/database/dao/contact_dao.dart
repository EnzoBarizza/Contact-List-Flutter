import 'package:sqflite/sqflite.dart' show Database;

import '../../models/contact.dart';
import '../app_database.dart';

class ContactDAO {
  static String get tableName => 'contacts';
  static String get tableSql =>
      'CREATE TABLE $tableName(id INTEGER PRIMARY KEY, name TEXT, phonenumber TEXT)';

  static Future<int> save(Contact contact) async {
    final Database db = await getDatabase();

    Map<String, dynamic> contactMap = contactToMap(contact);

    return db.insert(tableName, contactMap);
  }

  static Map<String, dynamic> contactToMap(Contact contact) {
    final Map<String, dynamic> contactMap = {};
    contactMap['name'] = contact.name;
    contactMap['phonenumber'] = contact.phoneNumber;
    return contactMap;
  }

  static Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> results = await db.query(tableName);

    return toList(results);
  }

  static List<Contact> toList(List<Map<String, dynamic>> results) {
    final List<Contact> contacts = [];

    for (Map<String, dynamic> map in results) {
      final Contact contact = Contact(
        name: map['name'],
        phoneNumber: map['phonenumber'],
        id: map['id'],
      );

      contacts.add(contact);
    }
    return contacts;
  }
}
