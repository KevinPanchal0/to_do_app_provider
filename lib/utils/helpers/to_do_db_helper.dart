import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app_provider/models/to_do_model.dart';

class ToDoDbHelper {
  ToDoDbHelper._();
  static final ToDoDbHelper toDoDbHelper = ToDoDbHelper._();
  Database? db;
  initDB() async {
    String dataBasePath = await getDatabasesPath();

    String path = join(dataBasePath, 'rnw.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE toDo(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,isCompleted INTEGER NOT NULL);";

        db.execute(query);
        log("==================");
        log("DataBaseCreated");
        log("==================");
      },
    );
  }

  Future<int> addToDO(ToDoModel toDo) async {
    await initDB();

    String query = "INSERT INTO toDo(title,isCompleted) VALUES(?,?)";
    List args = [
      toDo.tittle,
      toDo.isCompleted,
    ];

    return db!.rawInsert(query, args);
  }

  Future<List<ToDoModel>> fetchToDos() async {
    await initDB();

    String query = "SELECT * FROM toDo;";

    List<Map<String, Object?>> allRecord = await db!.rawQuery(query);

    List<ToDoModel> allRecordModel = allRecord.map((e) {
      return ToDoModel.fromMap(
        data: e,
      );
    }).toList();
    log(allRecordModel[0].tittle);
    return allRecordModel;
  }

  deleteToDoById(int id) async {
    await initDB();

    String query = "DELETE FROM toDo WHERE id=?";
    List args = [id];

    db!.rawDelete(query, args);
  }

  Future<int> editToDo(int id, String newTitle) async {
    await initDB();

    String query = "UPDATE toDo SET title = ? WHERE id = ?";

    List args = [newTitle, id];

    return db!.rawUpdate(query, args);
  }

  updateToDoStatus(int id, int isCompleted) async {
    await initDB();

    String query = "UPDATE toDo SET isCompleted = ? WHERE id = ?;";
    List args = [
      isCompleted,
      id,
    ];
    db!.rawUpdate(query, args);
  }
}
