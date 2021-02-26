import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {

  //open/set database
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_ieo');
    var database = await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);

    return database;
  }

  //creates db
  _onCreatingDatabase(Database database,int version) async {
    await database.execute('CREATE TABLE identifications(id INTEGER PRIMARY KEY, keyId TEXT, insectOrder TEXT, timestamp TEXT, latitude REAL, longitude REAL, photoURI TEXT)');
  }
}