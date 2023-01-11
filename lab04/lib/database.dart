import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'home_page.dart';
class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'gems.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE gems(
          id INTEGER PRIMARY KEY,
          name TEXT,
          description TEXT,
          color TEXT,
          hardness INTEGER,
          birthstone INTEGER
      )
      ''');
  }

  Future<List<Gem>> getGems() async {
    Database db = await instance.database;
    var gems = await db.query('gems', orderBy: 'name');
    List<Gem> gemList = gems.isNotEmpty
        ? gems.map((c) => Gem.fromMap(c)).toList()
        : [];
    return gemList;
  }

  Future<int> add(Gem gem) async {
    Database db = await instance.database;
    return await db.insert('gems', gem.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('gems', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Gem gem) async {
    Database db = await instance.database;
    return await db.update('gems', gem.toMap(),
        where: "id = ?", whereArgs: [gem.id]);
  }
}