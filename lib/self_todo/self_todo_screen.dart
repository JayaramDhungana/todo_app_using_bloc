import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_using_bloc/bloc/todo/todo_bloc.dart';
import 'package:todo_app_using_bloc/bloc/todo/todo_event.dart';
import 'package:todo_app_using_bloc/bloc/todo/todo_state.dart';
import 'package:todo_app_using_bloc/self_todo/add_todo_item.dart';
import 'package:todo_app_using_bloc/self_todo/update_todo_item.dart';

class SelfTodoScreen extends StatelessWidget {
  const SelfTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "My Todo List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocListener<SelfTodoBloc, SelfTodoState>(
          listener: (context, state) {
            if (state.status == TodoStatus.added) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: const [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Todo added successfully",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
            } else if (state.status == TodoStatus.deleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: const [
                      Icon(Icons.delete_forever, color: Colors.white),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Todo deleted",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
            } else if (state.status == TodoStatus.updated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: const [
                      Icon(Icons.edit, color: Colors.white),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Todo updated",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.blueAccent,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },

          child: BlocBuilder<SelfTodoBloc, SelfTodoState>(
            builder: (context, state) {
              if (state.selfToDoItem.isEmpty) {
                return const Center(
                  child: Text(
                    "No tasks yet. Add some!",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }

              return ListView.separated(
                itemCount: state.selfToDoItem.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final todoItemForShow = state.selfToDoItem[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue[100],
                        child: Text(
                          "${index + 1}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      title: Text(
                        todoItemForShow,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<SelfTodoBloc>().add(
                                DeleteToDo(toDoItemForDelete: todoItemForShow),
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateTodoItem(
                                    indexForUpdate: index,
                                    textForUpdate: todoItemForShow,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTodoItem()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
