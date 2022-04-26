import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = 'tasks';

  static Future<void> initDb() async {}
}
