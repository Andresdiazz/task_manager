import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_seek/presentation/blocs/add_cubit.dart';
import 'core/dependencies.dart';
import 'presentation/pages/task_home_page.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AddCubit())],
      child: MaterialApp(
        title: 'Task Manager',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: TaskHomePage(taskBloc: Dependencies.provideTaskBloc()),
      ),
    );
  }
}
