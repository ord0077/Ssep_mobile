import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ssepnew/models/BtlModel.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String TASK_NAME = 'task_name';
  static const String DISTRICT = 'district_name';
  static const String Status = 'status';


  static const String TABLE = 'record';
  static const String DB_NAME = 'db_btlrecord.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $TASK_NAME TEXT, $DISTRICT TEXT ,$Status TEXT )");
  }

  Future<Datum> save (Datum datum) async {
    var dbClient = await db;
    datum.id = await dbClient.insert(TABLE, datum.toMap());
    return datum;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }

  Future<List<Datum>> getEmployees() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID, TASK_NAME ,DISTRICT,Status]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Datum> record = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        record.add(Datum.fromMap(maps[i]));
      }
    }
    return record;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(Datum datum) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, datum.toMap(),
        where: '$ID = ?', whereArgs: [datum.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}