import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Action {
  final DateTime today = DateTime.now();
  final String actionName;
  late int muscles;
  List<int> weights = [0, 0, 0, 0];
  List<int> counts = [0, 0, 0, 0];

  Action({required this.actionName});

  Map<String, dynamic> toMap() {
    var date = today.toString().substring(0, 10);
    date = date.replaceAll(new RegExp(r'[^0-9]'), '');
    var actionId = int.parse(actionName); // read json files
    var itemId = int.parse(date) * 1000 + actionId;
    return {
      'itemId': itemId,
      'time': today.toString(),
      'weekday': today.weekday, // int, mon=1, sun=7
      'muscles': 0,
      'actionName': '平板哑铃卧推',
      'actionId': 0,
      'w0': weights[0],
      'w1': weights[1],
      'w2': weights[2],
      'w3': weights[3],
      'c0': counts[0],
      'c1': counts[1],
      'c2': counts[2],
      'c3': counts[3],
    };
  }
}

class DatabaseHelper {
  static final _dbName = 'training_record.db';
  static final _dbVersion = 1;
  static final _tableName = 'training';

  static final itemId = 'itemId';
  static final weekday = 'weekday';
  static final time = 'time';
  static final muscles = 'muscles';
  static final actionName = 'actionName';
  static final actionId = 'actionId';

  DatabaseHelper.internal();
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  Future<Database> get database async => _database ??= await initDB();

  Future<Database> initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), _dbName),
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  // define database format
  Future _onCreate(Database db, int version) {
    return db.execute('''
        CREATE TABLE $_tableName (
        $itemId INTEGER PRIMARY KEY, 
        $time TEXT, 
        $weekday INTEGER, 
        $muscles INTEGER,
        $actionName TEXT,
        $actionId INTEGER,
        'w0' INTEGER, 'w1' INTEGER, 'w2' INTEGER, 'w3' INTEGER,
        'c0' INTEGER, 'c1' INTEGER, 'c2' INTEGER, 'c3' INTEGER,)''');
  }

  Future<int> insertRecord(Action act) async {
    Database dbClient = await database;
    var result = await dbClient.insert(
      _tableName,
      act.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<int> updateRecord(Action act) async {
    Database dbClient = await database;
    var row = act.toMap();
    var result = await dbClient.update(_tableName, row,
        where: '$itemId = ?', whereArgs: [row[itemId]]);
    return result;
  }

  Future<int> deleteRecord(int itemId) async {
    Database dbClient = await database;
    var result = await dbClient
        .delete(_tableName, where: '$itemId = ?', whereArgs: [itemId]);
    return result;
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database dbClient = await database;
    return await dbClient.query(_tableName);
  }

  Future close() async {
    var dbClient = await database;
    return dbClient.close();
  }
}
