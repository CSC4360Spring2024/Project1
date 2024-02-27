import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/expense_model.dart';
import '../models/budget_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String expenseTable = 'expense_table';
  String budgetTable = 'budget_table';
  String colId = 'id';
  String colAmount = 'amount';
  String colDate = 'date';
  String colCategory = 'category';
  String colNotes = 'notes';
  String colTitle = 'title';
  String colStartDate = 'start_date';
  String colEndDate = 'end_date';

  DatabaseHelper._();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._();
    }
    return _databaseHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'expense.db');
    var expensesDatabase =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return expensesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $expenseTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colAmount REAL, $colDate TEXT, '
            '$colCategory TEXT, $colNotes TEXT)');
    await db.execute(
        'CREATE TABLE $budgetTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colAmount REAL, '
            '$colStartDate TEXT, $colEndDate TEXT)');
  }

  Future<int> insertExpense(Expense expense) async {
    Database db = await this.database;
    var result = await db.insert(expenseTable, expense.toMap());
    return result;
  }

  Future<List<Expense>> getExpenseList() async {
    Database db = await this.database;
    var result = await db.query(expenseTable, orderBy: '$colDate DESC');
    List<Expense> expenseList =
    result.map((item) => Expense.fromMap(item)).toList();
    return expenseList;
  }

  Future<int> insertBudget(Budget budget) async {
    Database db = await this.database;
    var result = await db.insert(budgetTable, budget.toMap());
    return result;
  }

  Future<List<Budget>> getBudgetList() async {
    Database db = await this.database;
    var result = await db.query(budgetTable);
    List<Budget> budgetList = result.map((item) => Budget.fromMap(item)).toList();
    return budgetList;
  }

  Future<int> deleteExpense(int id) async {
    Database db = await this.database;
    return await db.delete(expenseTable, where: '$colId = ?', whereArgs: [id]);
  }

}
