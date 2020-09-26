import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'Database.dart';

class Entry {
  final int id;
  final String qrString;
  final String timestamp;
  final int dataType;

  Entry({this.id, this.qrString, this.timestamp, this.dataType});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'qrString': qrString,
      'timestamp': timestamp,
      'dataType': dataType,
    };
  }
}

Future<void> insertEntry(Entry entry) async {
  print('entry ${entry.qrString} inserted');
  final Database db = await initiateDB();
  await db.insert(
    'entry',
    entry.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Entry>> entries() async {
  final Database db = await initiateDB();
  final List<Map<String, dynamic>> maps = await db.query('entry');
  return List.generate(maps.length, (i) {
    return Entry(
      id: maps[i]['id'],
      qrString: maps[i]['qrString'],
      timestamp: maps[i]['timestamp'],
      dataType: maps[i]['dataType'],
    );
  });
}

Future<void> deleteEntry(int id) async {
  final db = await initiateDB();
  await db.delete(
    'entry',
    where: "id = ?",
    whereArgs: [id],
  );
}

void testRetrieve() async {
  List<Entry> entriesList = await entries();
  for (var entry in entriesList) {
    print("${entry.id}, ${entry.qrString}, ${entry.timestamp}");
  }
}
