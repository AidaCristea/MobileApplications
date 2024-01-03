import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:smart_fin_flutter/Expense.dart';
import 'package:sqflite/sqflite.dart';

import '../Expense.dart';

class DBHelper {
  //DatabaseConnection

  final dbName = "smartFinDB3.db";
  final dbVersion = 1;
  final _table = "expense";

  DBHelper._();

  static final DBHelper dbInstance = DBHelper._();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDB();

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);

    return await openDatabase(path, version: dbVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS $_table
        (_id INTEGER PRIMARY KEY AUTOINCREMENT, 
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        amount INTEGER,
        category TEXT NOT NULL,
        date TEXT NOT NULL,
        payment_method TEXT NOT NULL)''');
  }


  Future<int> createExpense(Expense expense) async {
    var dbReady = await dbInstance.database;
    return await dbReady.insert(_table, expense.toMap());
  }

  Future<int> updateExpense(Expense expense) async {
    var dbReady = await dbInstance.database;
    return await dbReady.update(_table, expense.toMap(),
        where: '_id=?', whereArgs: [expense.id]);
  }

  Future<int> deleteExpense(int id) async {
    var dbReady = await dbInstance.database;
    return await dbReady.delete(_table, where: '_id = ?', whereArgs: [id]);
  }

  Future<List<Expense>> getExpenses() async {
    var dbReady = await dbInstance.database;
    var expenses = await dbReady.query(_table);

    List<Expense> expenseList = expenses.isNotEmpty
        ? expenses.map((e) => Expense.fromMap(e)).toList()
        : [];

    return expenseList;
  }
}
