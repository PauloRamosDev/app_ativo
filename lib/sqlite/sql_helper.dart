import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlHelper {
  static final SqlHelper _instance = SqlHelper.getInstance();
  static const tableDatabase = 'Database';
  static const tableHeaders = 'Headers';

  SqlHelper.getInstance();

  factory SqlHelper() => _instance;

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();

    return _db;
  }

  Future _initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'app_ativo.db');

    var db = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tableDatabase('
        'id INTEGER PRIMARY KEY,'
        'fieldOne TEXT,'
        'fieldTwo TEXT,'
        'fieldTree TEXT,'
        'fieldFour TEXT ,'
        'fieldFive TEXT,'
        'fieldSix TEXT,'
        'fieldSeven TEXT,'
        'fieldEigth TEXT'
        ')');

    await db.execute('CREATE TABLE $tableHeaders('
        'id INTEGER PRIMARY KEY,'
        'fieldOne TEXT,'
        'fieldTwo TEXT,'
        'fieldTree TEXT,'
        'fieldFour TEXT ,'
        'fieldFive TEXT,'
        'fieldSix TEXT,'
        'fieldSeven TEXT,'
        'fieldEigth TEXT'
        ')');
  }

  Future<FutureOr<void>> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion == 1 && newVersion == 2) {
//      await db.execute("alter table carro add column NOVA TEXT");
    }
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  Future<void> delete(table) async {
    var dbClient = await db;
    await dbClient.delete(table);
  }

  void alterTable(table, name) async {
    var bd = await db;

    bd.execute('ALTER TABLE $table ADD $name VARCHAR').catchError((error) {
      print(error.toString());
    });
  }
}
