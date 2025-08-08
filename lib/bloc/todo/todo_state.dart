import 'package:equatable/equatable.dart';
enum TodoStatus { initial, added, deleted, updated }
class SelfTodoState extends Equatable {
   final List<String> selfToDoItem;
     final TodoStatus status;

  const SelfTodoState({this.selfToDoItem= const [], this.status = TodoStatus.initial,});

  

  SelfTodoState copyWith(List<String>? selfToDoItem,  TodoStatus? status,) {
    return SelfTodoState(
      selfToDoItem:selfToDoItem??this.selfToDoItem,
       status: status ?? this.status,
      );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [selfToDoItem,status];
}
