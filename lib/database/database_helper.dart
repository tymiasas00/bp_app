import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:bp_app/models/bp_reading.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'blood_pressure.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE readings(
            id TEXT PRIMARY KEY,
            systolic INTEGER,
            diastolic INTEGER,
            pulse INTEGER,
            date TEXT,
            notes TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> insertReading(BloodPressureReading reading) async {
    final db = await database;
    await db.insert(
      'readings',
      reading.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<BloodPressureReading>> getReadings() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('readings');

    return List.generate(maps.length, (i) {
      return BloodPressureReading(
        id: maps[i]['id'],
        systolic: maps[i]['systolic'],
        diastolic: maps[i]['diastolic'],
        pulse: maps[i]['pulse'],
        date: DateTime.parse(maps[i]['date']),
        notes: maps[i]['notes'] ?? '',
      );
    });
  }

  Future<void> updateReading(BloodPressureReading reading) async {
    final db = await database;
    await db.update(
      'readings',
      reading.toMap(),
      where: 'id = ?',
      whereArgs: [reading.id],
    );
  }

  Future<void> deleteReading(String id) async {
    final db = await database;
    await db.delete(
      'readings',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
