import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:collection';
import 'package:flutter/material.dart';

class RecordItem {
  int idx = 0;
  int id = 0;
  List<int> weights = [0, 0, 0, 0];
  List<int> counts = [0, 0, 0, 0];
  RecordItem(this.idx, this.id, this.weights, this.counts);
}

class AllRecordItemModel extends ChangeNotifier {
  final List<RecordItem> _records = [];
  //访问数据，禁止改变记录数据
  UnmodifiableListView<RecordItem> get records =>
      UnmodifiableListView(_records);
  //添加or更新记录数据
  void add(RecordItem item) {
    int a = -1;
    _records.forEach((element) {
      //检测是否之前添加过该动作
      if (element.idx == item.idx) {
        a = _records.indexOf(element);
        _records.replaceRange(a, a + 1, [item]);
      }
    });
    if (a == -1) {
      _records.add(item);
    }
    notifyListeners();
  }
}

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
