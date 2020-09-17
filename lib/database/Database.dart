import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initiateDB() async {
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'qrDB.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE entry(id INTEGER PRIMARY KEY AUTOINCREMENT, qrString TEXT, timestamp TEXT)",
      );
    },
    version: 1,
  );

  return database;
}
