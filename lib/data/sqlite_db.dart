import 'dart:async';

import 'package:aastu_ecsf/model/notif.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteDb {
  static SQLiteDb? _sqLiteDb;
  static Database? _database;

  SQLiteDb._createObject();

  factory SQLiteDb() {
    if (_sqLiteDb == null) {
      _sqLiteDb = SQLiteDb._createObject();
    }
    return _sqLiteDb!;
  }

  Future<Database> init() async {
    return openDatabase(
      join(await getDatabasesPath(), 'materialx_flutter.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE notification("
          "id INTEGER PRIMARY KEY, title TEXT, content TEXT, type TEXT, "
          "image TEXT, link TEXT, createdAt INTEGER, isRead INTEGER"
          ")",
        );
      },
      version: 1,
    );
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await init();
    }
    return _database;
  }

  Future<int> insertNotification(Notif obj) async {
    Database db = await (this.database as FutureOr<Database>);
    Map<String, dynamic> map = obj.toJson();
    map["isRead"] = obj.isRead ? 1 : 0;
    return await db.insert(
      'notification',
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateNotification(Notif obj) async {
    Database db = await (this.database as FutureOr<Database>);
    Map<String, dynamic> map = obj.toJson();
    map["isRead"] = obj.isRead ? 1 : 0;
    return await db.update(
      'notification',
      map,
      where: "id = ?",
      whereArgs: [obj.id],
    );
  }

  Future<int> deleteNotification(int? id) async {
    Database db = await (this.database as FutureOr<Database>);
    return await db.delete(
      'notification',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    Database db = await (this.database as FutureOr<Database>);
    return await db.delete(
      'notification',
      where: "id > ?",
      whereArgs: [0],
    );
  }

  Future<List<Notif>> getNotifications() async {
    Database db = await (this.database as FutureOr<Database>);
    List<Map<String, dynamic>> maps =
        await db.query('notification', orderBy: "id DESC");
    return List.generate(maps.length, (i) {
      Notif obj = Notif(maps[i]['title'], maps[i]['content']);
      obj.id = maps[i]['id'];
      obj.type = maps[i]['type'];
      obj.image = maps[i]['image'];
      obj.link = maps[i]['link'];
      obj.createdAt = maps[i]['createdAt'];
      obj.isRead = maps[i]['isRead'] == 1;
      return obj;
    });
  }
}
