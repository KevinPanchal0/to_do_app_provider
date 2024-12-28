import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_provider/utils/helpers/to_do_db_helper.dart';
import 'package:to_do_app_provider/utils/to_input_widget.dart';
import 'package:to_do_app_provider/view_model/to_do_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  loadDb() async {
    await ToDoDbHelper.toDoDbHelper.initDB();
  }

  @override
  void initState() {
    super.initState();
    loadDb();
  }

  @override
  Widget build(BuildContext context) {
    final toDoViewModel = Provider.of<ToDoViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'To - DO',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: toDoViewModel.loadToDos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Consumer<ToDoViewModel>(
            builder: (context, viewModel, child) {
              return viewModel.toDoList.isEmpty
                  ? Center(child: Text("No Data Available"))
                  : ListView.builder(
                      itemCount: viewModel.toDoList.length,
                      itemBuilder: (context, index) {
                        final toDo = viewModel.toDoList[index];
                        return Slidable(
                          key: const ValueKey(0),
                          closeOnScroll: true,
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.3,
                            children: [
                              SizedBox(
                                width: 25,
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _showEditDialog(
                                    context,
                                    toDo.id!,
                                    toDo.tittle,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors
                                      .blue, // Background color for Edit button
                                  foregroundColor:
                                      Colors.white, // Text/Icon color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12), // Rounded corners
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                ),
                                icon: const Icon(Icons.edit, size: 20),
                                label: const Text(
                                  'Edit',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            dragDismissible: true,
                            // A pane can dismiss the Slidable.
                            extentRatio: 0.3,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () async {
                                  await toDoViewModel.deleteToDo(toDo.id!);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors
                                      .red, // Background color for Delete button
                                  foregroundColor:
                                      Colors.white, // Text/Icon color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12), // Rounded corners
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                ),
                                icon: const Icon(Icons.delete, size: 20),
                                label: const Text(
                                  'Delete',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 20),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Checkbox(
                                      value: toDo.isCompleted == 1,
                                      shape: const ContinuousRectangleBorder(),
                                      onChanged: (value) {
                                        toDoViewModel.toggleCompletion(
                                          id: toDo.id!,
                                          isCompleted: value! ? 1 : 0,
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 17,
                                    child: Text(
                                      toDo.tittle,
                                      style: TextStyle(
                                        fontSize: 18,
                                        decoration: (toDo.isCompleted == 1)
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.yellow[200],
            context: context,
            builder: (context) => ToInputWidget(),
          );
        },
        shape: CircleBorder(),
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add),
      ),
    );
  }
}

void _showEditDialog(BuildContext context, int id, String currentTitle) {
  final TextEditingController controller =
      TextEditingController(text: currentTitle);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit To-Do'),
        content: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'New Title',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.trim().isNotEmpty) {
                await Provider.of<ToDoViewModel>(context, listen: false)
                    .updateToDo(id, controller.text.trim());

                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('To-Do updated successfully!'),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Title cannot be empty!'),
                  ),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
