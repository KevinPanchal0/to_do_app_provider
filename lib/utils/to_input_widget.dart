import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_provider/models/to_do_model.dart';
import 'package:to_do_app_provider/view_model/to_do_view_model.dart';

class ToInputWidget extends StatefulWidget {
  const ToInputWidget({super.key});

  @override
  State<ToInputWidget> createState() => _ToInputWidgetState();
}

class _ToInputWidgetState extends State<ToInputWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String title;
  late bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow[200],
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Adjust height dynamically
        children: [
          Form(
            key: formKey,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter a thing to do.";
                } else {
                  return null;
                }
              },
              onSaved: (newValue) {
                title = newValue!;
                isCompleted = false;
              },
              decoration: InputDecoration(
                labelText: "To-Do Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15), // Replace spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    ToDoModel toDoModel = ToDoModel(
                        tittle: title, isCompleted: isCompleted ? 1 : 0);
                    await Provider.of<ToDoViewModel>(context, listen: false)
                        .addToDo(toDoModel);
                    FocusScope.of(context).unfocus();
                    formKey.currentState!.reset();
                    Navigator.of(context).pop();
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.yellow),
                  foregroundColor: WidgetStateProperty.all(Colors.black),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                child: const Text('Add To-Do'),
              ),
              const SizedBox(width: 15), // Replace spacing
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text('Cancelled'),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.yellow),
                  foregroundColor: WidgetStateProperty.all(Colors.black),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
