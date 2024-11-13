import 'dart:io';

import 'package:app_task/src/models/task.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'tasks';

  // Initialize the database
  static Future<void> initDb() async {
    if (_db != null) {
      debugPrint("Database already initialized.");
      return;
    }
    try {
      String _path =
          '${await getDatabasesPath()}${Platform.pathSeparator}tasks.db';

      debugPrint("Initializing database at $_path");
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          debugPrint("Creating a new database.");
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title STRING, description TEXT, date STRING, "
            "startTime STRING, endTime STRING, "
            "remind INTEGER, repeat STRING, "
            "color INTEGER, "
            "isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      debugPrint("Error initializing database: $e");
    }
  }

  // Insert a task
  static Future<int> insert(TaskModel task) async {
    if (_db == null) throw Exception("Database is not initialized.");
    print("Insert function called");
    return await _db!.insert(_tableName, task.toJson());
  }

  // Delete a task
  static Future<int> delete(TaskModel task) async {
    if (_db == null) throw Exception("Database is not initialized.");
    return await _db!.delete(_tableName, where: 'id = ?', whereArgs: [task.id]);
  }

  // Query all tasks
  static Future<List<Map<String, dynamic>>> query() async {
    if (_db == null) throw Exception("Database is not initialized.");
    print("Query function called");
    return await _db!.query(_tableName);
  }

  // Update a task
  static Future<int> update(int? id) async {
    if (_db == null) throw Exception("Database is not initialized.");
    print("Update function called");
    return await _db!.rawUpdate('''
      UPDATE $_tableName   
      SET isCompleted = ?
      WHERE id = ?
    ''', [1, id]);
  }
}
