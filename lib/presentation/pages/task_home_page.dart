import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_seek/presentation/blocs/add_cubit.dart';

import '../../domain/entities/task.dart';
import '../blocs/task_bloc.dart';
import '../widgets/task_list_widget.dart';

/// Screen to display the list of tasks and provide task management actions.
///
/// This widget uses `TaskBloc` to manage the state and display tasks,
/// with options to add, delete, and filter tasks based on completion status.
class TaskHomePage extends StatelessWidget {
  final TaskBloc taskBloc;

  const TaskHomePage({Key? key, required this.taskBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showAddInput = context.watch<AddCubit>().state;
    return BlocProvider.value(
      value: taskBloc,
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  const _BannerContainer(),
                  if (showAddInput)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: TextEditingController(),
                              decoration: InputDecoration(
                                  labelText: 'New Task',
                                  border: OutlineInputBorder(
                                      gapPadding: 10,
                                      borderRadius: BorderRadius.circular(23))),
                              onSubmitted: (value) {
                                if (value.isNotEmpty) {
                                  taskBloc.addTask(Task(
                                      id: UniqueKey().toString(),
                                      title: value));
                                  context.read<AddCubit>().showAddInput();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  const TaskListWidget(),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
            if (!showAddInput)
              Center(
                child: IconButton.filled(
                    iconSize: 40,
                    onPressed: () {
                      context.read<AddCubit>().showAddInput();
                    },
                    icon: const Icon(Icons.add_rounded)),
              )
          ],
        ),
      ),
    );
  }
}

class _BannerContainer extends StatelessWidget {
  const _BannerContainer();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<TaskBloc, Map<String, List<Task>>>(
        builder: (context, state) {
      final tasks = state['totalTasks'] ?? [];
      final completedTasks = state['completedTasks'] ?? [];

      return Stack(
        children: [
          Container(
            height: size.height * 0.5,
            width: size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://images.pexels.com/photos/2693212/pexels-photo-2693212.png?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
          ),
          Container(
            height: size.height * 0.5,
            width: size.width,
            decoration: const BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(),
                  const Text(
                    'Daily\nTasks',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  Text(
                    '${completedTasks.length}/${tasks.length}\ntasks',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
