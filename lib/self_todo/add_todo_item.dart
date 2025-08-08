import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_using_bloc/bloc/todo/todo_bloc.dart';
import 'package:todo_app_using_bloc/bloc/todo/todo_event.dart';

class AddTodoItem extends StatefulWidget {
  const AddTodoItem({super.key});

  @override
  State<AddTodoItem> createState() => _AddTodoItemState();
}

class _AddTodoItemState extends State<AddTodoItem> {
  final TextEditingController todoController = TextEditingController();
  final FocusNode itemFocusNode = FocusNode();

  @override
  void dispose() {
    todoController.dispose();
    itemFocusNode.dispose();
    super.dispose();
  }

  void _handleAddTodo(BuildContext context) {
    final text = todoController.text.trim();
    if (text.isNotEmpty) {
      context.read<SelfTodoBloc>().add(AddTodo(todoItem: text));
      Navigator.pop(context); // Go back to previous screen
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
        title: const Text("Add Todo"),
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
                focusNode: itemFocusNode,
                controller: todoController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: "Enter todo item",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.edit_note),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _handleAddTodo(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Add Todo",
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
