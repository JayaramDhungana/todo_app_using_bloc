

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_using_bloc/bloc/todo/todo_event.dart';
import 'package:todo_app_using_bloc/bloc/todo/todo_state.dart';

class SelfTodoBloc extends Bloc<SelfTodoEvent, SelfTodoState> {
  List<String> todoItems = [];
  SelfTodoBloc() : super(SelfTodoState()) {
    on<AddTodo>(_addToDoItem);
    on<DeleteToDo>(_deleteToDoItem);
    on<UpdateTODO>(_updateToDoItem);
  }

  void _addToDoItem(AddTodo event, Emitter<SelfTodoState> emit) {
    todoItems.add(event.todoItem);

    emit(state.copyWith(List.from(todoItems),TodoStatus.added,));
  }

  void _deleteToDoItem(DeleteToDo event, Emitter<SelfTodoState> emit) {
    todoItems.remove(event.toDoItemForDelete);
    emit(state.copyWith(List.from(todoItems),TodoStatus.deleted,));
  }

  void _updateToDoItem(UpdateTODO event, Emitter<SelfTodoState> emit) {
    todoItems[event.indexOfToDoItem] = event.toDoItemForUpdate;
    emit(state.copyWith(List.from(todoItems),TodoStatus.updated,));
  }
}
