import 'package:flutter/material.dart';
import 'package:to_do_app_provider/models/to_do_model.dart';
import 'package:to_do_app_provider/utils/helpers/to_do_db_helper.dart';

class ToDoViewModel extends ChangeNotifier {
  List<ToDoModel> toDoList = [];

  Future<void> loadToDos() async {
    toDoList = await ToDoDbHelper.toDoDbHelper.fetchToDos();
    notifyListeners();
  }

  Future<void> addToDo(ToDoModel toDo) async {
    await ToDoDbHelper.toDoDbHelper.addToDO(toDo);
    toDoList.add(toDo);
    loadToDos();
    notifyListeners();
  }

  Future<void> deleteToDo(int id) async {
    await ToDoDbHelper.toDoDbHelper.deleteToDoById(id);
    toDoList.removeWhere((toDo) => toDo.id == id);
    notifyListeners();
  }

  Future<void> updateToDo(int id, String newTitle) async {
    int result = await ToDoDbHelper.toDoDbHelper.editToDo(id, newTitle);
    if (result > 0) {
      final index = toDoList.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        toDoList[index].tittle = newTitle;
        notifyListeners(); // Notify UI to refresh
      }
    }
  }

  Future<void> toggleCompletion(
      {required int id, required int isCompleted}) async {
    // Update in the database
    await ToDoDbHelper.toDoDbHelper.updateToDoStatus(id, isCompleted);

    // Update in the local list
    final index = toDoList.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      toDoList[index].isCompleted = isCompleted;
    }
    loadToDos();
    notifyListeners();
  }
  // Future<void> toggleCompletion(ToDoModel toDo) async {
  //   toDo.isCompleted = !toDo.isCompleted;
  //   await ToDoDbHelper.toDoDbHelper.updateToDo(toDo);
  //   notifyListeners();
  // }
}
