import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB{

  DB._();

  static final DB instance = DB._();

  static Database? _database;

  get database async {

    if(_database != null) return _database;

    return await _initDatabase();

  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'dreamlabs_challenge.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }
  _onCreate(db, version) async{
    await db.execute(_jsonData);
  }

  String get _jsonData => '''
    CREATE TABLE json_data(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      id_json INTEGER,
      user_id INTEGER,
      title TEXT,
      body TEXT
    );
    ''';



}