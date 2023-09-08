import 'package:sqflite/sqflite.dart';
import 'package:tp_note_flutter/database/db_connection.dart';

import '../models/user.dart';

class UserRepository {
  late DatabaseConnection connection;

  UserRepository() {
    connection = DatabaseConnection();
  }

  static Database? _database;

  String table = "users";

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await connection.setDatabase();
    return _database;
  }

  Future<int?> insertUser(User user) async {
    var connection = await database;
    return await connection?.insert(
      table,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>?> getUserList() async {
    var connection = await database;
    final data =  await connection?.query(table);
    return data!.map((e) => User.fromMap(e)).toList();
  }

  Future<int> countUsers() async {
    var connection = await database;
    return Sqflite.firstIntValue(await connection!.rawQuery('SELECT COUNT(*) FROM $table')) ?? 0;
  }

  Future<User?> getUser(int userId) async {
    var connection = await database;
    final data = await connection?.query(table, where: 'id = ?', whereArgs: [userId]);
    if(data!.isNotEmpty) {
      return User.fromMap(data.first);
    }
  }

  Future<User?> findUser(String name, String password) async {
    var connection = await database;
    final data = await connection?.query(table, where: 'name = ? AND userPassword = ?', whereArgs: [name, password]);
    if(data!.isNotEmpty) {
      return User.fromMap(data.first);
    }
  }

  Future<int?> updateUser(User user) async {
    var connection = await database;
    return await connection?.update(table, user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }
}
