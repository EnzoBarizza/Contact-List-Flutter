import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/contact.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), "contacts.db");

  return openDatabase(path, onCreate: (db, version) {
    db.execute(
        'CREATE TABLE contacts(id INTEGER PRIMARY KEY, name TEXT, phonenumber TEXT)');
  }, version: 1);
}

void save(Contact contact) async {
  final Database db = await getDatabase();

  final Map<String, dynamic> contactMap = {};
  contactMap['name'] = contact.name;
  contactMap['phonenumber'] = contact.phoneNumber;

  db.insert('contacts', contactMap);
}

Future<List<Contact>> findAll() async {
  final Database db = await getDatabase();
  final List<Map<String, dynamic>> results = await db.query('contacts');
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
