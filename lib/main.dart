import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_using_bloc/bloc/todo/todo_bloc.dart';
import 'package:todo_app_using_bloc/self_todo/self_todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => SelfTodoBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(
          
        ),
        title: 'Flutter Demo',
        home: SelfTodoScreen(),
      ),
    );
  }
}
