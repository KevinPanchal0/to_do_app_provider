class ToDoModel {
  int? id;
  String tittle;
  int isCompleted;

  ToDoModel({
    this.id,
    required this.tittle,
    required this.isCompleted,
  });

  factory ToDoModel.fromMap({required Map data}) {
    return ToDoModel(
      id: data['id'],
      tittle: data['title'],
      isCompleted: data['isCompleted'] ?? 0,
    );
  }
}
