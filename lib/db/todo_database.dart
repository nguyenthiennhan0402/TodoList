import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/db/todo_table.dart';

class TodoDatabase{
  static const DB_NAME = 'todo.db';
  static const DB_VERSION = 1;
  static late Database _database;
  TodoDatabase._internal();
  static final TodoDatabase instance = TodoDatabase._internal();
  Database get database => _database;

  static const initScript = [TodoTable.CREATE_TABLE_QUERY];
  static const migrationScript = [TodoTable.CREATE_TABLE_QUERY];

  init() async {
    _database = await openDatabase(
        join(await getDatabasesPath(), DB_NAME),
        onCreate:(db, version){
          initScript.forEach((script) async => await db.execute(script));
        },
        onUpgrade: (db, oldVersion, newVersion){
            migrationScript.forEach((script) async => await db.execute(script));
        },
      version: DB_VERSION
    );
  }

}