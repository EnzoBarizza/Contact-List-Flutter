import 'dart:async';

import 'package:contacts/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), "contacts.db");

  return openDatabase(path, onCreate: (db, version) {
    db.execute(ContactDAO.tableSql);
  }, version: 1);
}
