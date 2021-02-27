import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static final _databaseName = "studentDetails.db";
  static final _databaseVersion = 1;

  static final table = "student";

  static final columnID = 'id';
  static final columnNo = 'rollNo';
  static final columnName = 'name';

  static Database _database;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async{
    if(_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,_databaseName);
    return await openDatabase(path,version:_databaseVersion,onCreate:_onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute(
    '''
      CREATE TABLE $table(
        $columnID INTEGER PRIMARY KEY,
        $columnNo INTEGER NOT NULL,
        $columnName TEXT NOT NULL
    )
      '''
    );

  }

  // functions to insert,select, update,delete
  Future<int> insert(Map<String,dynamic> row)async{
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String,dynamic>>> fetchall() async{
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String,dynamic>>> getstudentById(int num) async{
    Database db = await instance.database;
    var result = await db.query(table,where:"rollNo = ?",whereArgs:[num]);
    // var result = await db.rawQuery('SELECT * FROM student WHERE rollNo = ?',[num]);
    return result;
  }

  Future<int> deleteRow(int id) async{
    Database db = await instance.database;
    var result = await db.delete(table,where:"id = ?",whereArgs:[id]);
    return result;
  }

  Future<int> update(int id) async{
    Database db = await instance.database;
    var result = await db.update(table,{"name":"TechChia","rollNo":4},where:"id =?",whereArgs:[id]);
    return result;
  }
}