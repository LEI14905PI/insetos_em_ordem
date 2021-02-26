import 'package:insetos_em_ordem/database/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  DatabaseConnection _databaseConnection;

  DatabaseHelper(){
    //initialize db con
    _databaseConnection = DatabaseConnection();
  }

  static Database _database;

  Future<Database> get database async {
    if(_database!=null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  //insert data
  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  //read data
  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  //read data
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection.query(table, where: 'rowid=?', whereArgs: [itemId]);
  }

  //read data
  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection.rawDelete("DELETE FROM $table WHERE rowid = $itemId");
  }

}