import 'package:appativo/models/model_data.dart';
import 'package:appativo/sqlite/sql_helper.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseDAO {
  Future<Database> get db => SqlHelper.getInstance().db;

  Future<int> insert(Data registro) async {
    var dbClient = await db;
    var id = await dbClient.insert(SqlHelper.tableDatabase, registro.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<int> insertHeader(header) async {
    var dbClient = await db;
    var id = await dbClient.insert(SqlHelper.tableHeaders, header,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<int> update(Data registro, String idSqlite) async {
    var dbClient = await db;
    var id = await dbClient.update(SqlHelper.tableDatabase, registro.toJson(),
        where: 'fieldOne = $idSqlite', conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  delete() {}

  Future<Data> findById(int id) async {
    var dbClient = await db;
    final list = await dbClient.rawQuery(
        'select * from ${SqlHelper.tableDatabase} where id = ?', [id]);

    if (list.length > 0) {
      return new Data.fromJson(list.first);
    }

    return null;
  }

  Future<Data> headers() async {
    final dbClient = await db;

    final list =
        await dbClient.rawQuery('select * from ${SqlHelper.tableHeaders}');

    final headers =
        list.map<Data>((json) => Data.fromJson(json)).toList().first;

    return headers;
  }

  Future<List<Data>> findAll() async {
    final dbClient = await db;

    final list =
        await dbClient.rawQuery('select * from ${SqlHelper.tableDatabase}');

    final funcionarios = list.map<Data>((json) => Data.fromJson(json)).toList();

    return funcionarios;
  }

  Future deleteAll() async {
    var dbClient = await db;

    return await dbClient.rawQuery('DELETE FROM ${SqlHelper.tableDatabase}');
  }

  Future<int> count() async {
    final dbClient = await db;

    final list = await dbClient
        .rawQuery('select count(*) from ${SqlHelper.tableDatabase}');
    return Sqflite.firstIntValue(list);
  }
}