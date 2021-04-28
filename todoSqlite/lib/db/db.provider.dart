import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoSqlite/model/task.model.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider dataBase = DBProvider._();
  static Database _database;

  // Now let's create a getter for our  class
  Future<Database> get database async {
    // we check if we already have a db
    if (_database != null) {
      return _database;
    }
    //  else we create a new database
    _database = await initDataBase();
    return _database;
  }

  // creating the db initialiser
  initDataBase() async {
    return await openDatabase(join(await getDatabasesPath(), 'todo_app_db.db'),
        onCreate: (db, version) async {
      await db.execute('''
            CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT, creationDate TEXT) 
          ''');
    }, version: 1);
  }

  // Adding Newtask
  addNewTask(Task newTask) async {
    final db = await database;
    // we will use the insert function
    db.insert('tasks', newTask.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Getting the tasks from the db
  Future<dynamic> getTask() async {
    final db = await database;
    var res = await db.query('tasks');
    if (res.length == 0) {
      return Null;
    } else {
      var resultMap = res.toList();
      return resultMap.isNotEmpty ? resultMap : Null;
    }
  }
}
