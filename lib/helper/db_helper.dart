import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:student_app/models/student.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _dataBase;

  static String _studentTable = "studentTable";
  static String _id = "id";
  static String _name = "name";
  static String _dob = "dob";
  static String _fName = "fName";
  static String _mName = "mName";

  DatabaseHelper._createInstance();

  //region get singletone db instance
  Future<Database> get database async {
    if (_dataBase == null) {
      _dataBase = await initializeDatabase();
    }
    return _dataBase;
  }

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }
  //endregion

  //region init db with common file path
  Future<Database> initializeDatabase() async {
    //get the common directory path for both android and ios to store db
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "student.db";
    //create the db into the path
    var studentDb = await openDatabase(path, version: 1, onCreate: _createDb);
    return studentDb;
  }
  //endregion

  //region create db with query
  void _createDb(Database db, int dbVersion) async {
    await db.execute(
        'CREATE TABLE $_studentTable ($_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $_name TEXT, $_dob TEXT, $_fName TEXT, $_mName TEXT)');
  }
  //endregion

  //region get all records
  Future<List<Map<String, dynamic>>> getAllStudents() async {
    Database db = await this.database;
    var result = await db.query(_studentTable, orderBy: "$_name asc");
    return result;
  }
  //endregion

  //region add new record
  Future<int> add(Student student) async {
    Database db = await this.database;
    var result = await db.insert(_studentTable, student.toMap());
    return result;
  }
  //endregion

  //region update record
  Future<int> update(Student student) async {
    Database db = await this.database;
    var result = await db.update(_studentTable, student.toMap(),
        where: "$_id = ?", whereArgs: [student.id]);
    return result;
  }
  //endregion

  //region delete record
  Future<int> delete(int id) async {
    Database db = await this.database;
    var result = await db.delete(_studentTable, where: "$_id = $id");
    return result;
  }
  //endregion

  //region get record count
  Future<int> getRecordCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> records =
        await db.rawQuery(" select count(*) from $_studentTable");
    var result = Sqflite.firstIntValue(records);
    return result;
  }
  //endregion

  //region get list object from map
  Future<List<Student>> getListObjectFromMap() async {
    var allStudentsMap = await getAllStudents();

    List<Student> students = new List<Student>();

    for (int start = 0; start < allStudentsMap.length; start++) {
      students.add(Student.fromMapObject(allStudentsMap[start]));
    }
    return students;
  }
  //endregion
}
