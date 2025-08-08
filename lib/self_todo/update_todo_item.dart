import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_using_bloc/bloc/todo/todo_bloc.dart';
import 'package:todo_app_using_bloc/bloc/todo/todo_event.dart';

class UpdateTodoItem extends StatefulWidget {
  final int indexForUpdate;
  final String textForUpdate;

  const UpdateTodoItem({
    super.key,
    required this.indexForUpdate,
    required this.textForUpdate,
  });

  @override
  State<UpdateTodoItem> createState() => _UpdateTodoItemState();
}

class _UpdateTodoItemState extends State<UpdateTodoItem> {
  late TextEditingController todoController;
  final FocusNode itemFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    todoController = TextEditingController(text: widget.textForUpdate);
  }

  @override
  void dispose() {
    todoController.dispose();
    itemFocusNode.dispose();
    super.dispose();
  }

  void _handleUpdate(BuildContext context) {
    final updatedText = todoController.text.trim();
    if (updatedText.isNotEmpty) {
      context.read<SelfTodoBloc>().add(
        UpdateTODO(
          toDoItemForUpdate: updatedText,
          indexOfToDoItem: widget.indexForUpdate,
        ),
      );
      Navigator.pop(context); // Instead of pushing same screen again
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter a todo item")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Todo"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              TextFormField(
                controller: todoController,
                focusNode: itemFocusNode,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: "Update your todo item",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.edit),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _handleUpdate(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Update Todo",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
