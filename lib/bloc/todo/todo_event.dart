import 'package:equatable/equatable.dart';

abstract class SelfTodoEvent extends Equatable {}

class AddTodo extends SelfTodoEvent {
  String todoItem;

  AddTodo({required this.todoItem});

  @override
  // TODO: implement props
  List<Object?> get props => [todoItem];
}

class DeleteToDo extends SelfTodoEvent {
  String toDoItemForDelete;

  DeleteToDo({required this.toDoItemForDelete});

  @override
  // TODO: implement props
  List<Object?> get props => [toDoItemForDelete];
}

class UpdateTODO extends SelfTodoEvent {
  String toDoItemForUpdate;
  int indexOfToDoItem;
  UpdateTODO({required this.toDoItemForUpdate,required this.indexOfToDoItem});

  @override
  // TODO: implement props
  List<Object?> get props => [toDoItemForUpdate];
}
