import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:finplan/models/user.dart';
import 'package:finplan/models/finance.dart';
import 'package:finplan/constant/finance_type_constants.dart';

class DbHelper {
  static DbHelper? _dbHelper;
  static Database? _database;

  final String tableUser = 'user';
  final String columnUserId = 'id';
  final String columnEmail = 'email';
  final String columnPassword = 'password';

  final String tableFinance = 'finance';
  final String columnFinanceId = 'id';
  final String columnDate = 'date';
  final String columnAmount = 'amount';
  final String columnDescription = 'description';
  final String columnType = 'type';

  DbHelper._createObject();

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}finplan.db';

    //create, read databases
    var itemDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    return itemDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableUser (
    $columnUserId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnEmail TEXT,
    $columnPassword TEXT
  )''');

    await db.execute('''
    CREATE TABLE $tableFinance (
    $columnFinanceId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnDate TEXT,
    $columnAmount TEXT,
    $columnType TEXT,
    $columnType TEXT
  )''');

    // insert to table user
    await db
        .insert("user", {'email': 'faris@mail.com', 'password': 'password'});
  }

  //* User
  //create databases user
  Future<int> insertUser(User object) async {
    Database db = await database;
    int count = await db.insert(tableUser, object.toMap());
    return count;
  }

  // create login user return true or false
  Future<bool> loginUser(String email, String password) async {
    Database db = await database;

    List<Map<String, dynamic>> result = await db.query(tableUser,
        where: 'email = ? AND password = ?', whereArgs: [email, password]);
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  // create change password
  Future<int> changePassword(String email, String password) async {
    Database db = await database;

    int result = await db.rawUpdate(
        'UPDATE user SET password = ? WHERE email = ?', [password, email]);
    return result;
  }

  // get user login data
  Future<List<User>> getUserLogin(String email) async {
    Database db = await database;
    List<Map<String, dynamic>> result =
        await db.query(tableUser, where: 'email = ?', whereArgs: [email]);

    List<User> users = [];
    for (var i = 0; i < result.length; i++) {
      users.add(User.fromMap(result[i]));
    }
    return users;
  }

  // Add this method to DbHelper
  Future<User?> getUserByEmail(String email) async {
    Database db = await database;
    List<Map<String, dynamic>> result =
        await db.query('user', where: 'email = ?', whereArgs: [email]);

    if (result.isNotEmpty) {
      return User.fromMap(result[0]);
    } else {
      return null;
    }
  }

  //* Finance
  //create databases finance
  Future<int> insertFinance(Finance object) async {
    Database db = await database;
    int count = await db.insert(tableFinance, object.toMap());
    return count;
  }

  Future<int> insertIncome(
      String date, String amount, String description) async {
    Database db = await database;

    // Create a Finance object with the income data
    Finance incomeData = Finance(date, amount, description, incomeType);

    int count = await db.insert(tableFinance, incomeData.toMap());
    return count;
  }

  Future<int> insertOutcome(
      String date, String amount, String description) async {
    Database db = await database;

    // Create a Finance object with the expense data
    Finance expenseData = Finance(date, amount, description, outcomeType);

    int count = await db.insert(tableFinance, expenseData.toMap());
    return count;
  }

// get total from income
  Future<int> getTotalIncome() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT SUM(amount) as total FROM finance where type = "income"');

    if (result.isNotEmpty && result[0]['total'] != null) {
      int total = result[0]['total'];
      return total;
    } else {
      // Handle the case where there is no data or 'total' is null
      return 0; // You can return a default value or an appropriate error value
    }
  }

  // get total from expense
  Future<int> getTotalOutcome() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT SUM(amount) as total FROM finance where type = "outcome"',
    );

    if (result.isNotEmpty && result[0]['total'] != null) {
      int total = result[0]['total'];
      return total;
    } else {
      // Handle the case where there is no data or 'total' is null
      return 0; // You can return a default value or an appropriate error value
    }
  }

  // get total outcome by month
  Future<int> getTotalExpenseByMonth(String month) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT SUM(amount) as total FROM finance where type = "expense" AND date LIKE "%$month%"',
    );

    if (result.isNotEmpty && result[0]['total'] != null) {
      int total = result[0]['total'];
      return total;
    } else {
      // Handle the case where there is no data or 'total' is null
      return 0; // You can return a default value or an appropriate error value
    }
  }

  // get data from finance
  Future<List<Finance>> getFinance() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(tableFinance);

    List<Finance> finance = [];
    for (var i = 0; i < result.length; i++) {
      finance.add(Finance.fromMap(result[i]));
    }
    return finance;
  }

  // delete data finance
  Future<int> deleteDataFinance(int id) async {
    Database db = await database;
    int count = await db.delete(tableFinance, where: 'id=?', whereArgs: [id]);
    return count;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database!;
  }
}
