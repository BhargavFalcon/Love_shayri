import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Database? _database;
  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = join(databasesPath, 'Quote.sqlite');

    // Copy database if not exists
    if (!await File(dbPath).exists()) {
      ByteData data = await rootBundle.load('assets/db/Quote.sqlite');
      List<int> bytes = data.buffer.asUint8List();
      await File(dbPath).writeAsBytes(bytes);
    }

    // Open the database
    final db = await openDatabase(dbPath);
    // List all tables for debugging
    _database = db;
    return db;
  }

  Future<List<Map<String, dynamic>>> executeQuery(String query) async {
    final db = _database;
    try {
      return await db!.query(query);
    } catch (e) {
      print('Error executing query: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> rawQuery(String query) async {
    final db = _database;
    try {
      return await db!.rawQuery(query);
    } catch (e) {
      print('Error executing query: $e');
      return [];
    }
  }
}
