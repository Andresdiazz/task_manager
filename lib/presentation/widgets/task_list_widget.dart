import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/task.dart';
import '../blocs/task_bloc.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<TaskBloc, Map<String, List<Task>>>(
      builder: (context, state) {
        final tasks = state['tasks'] ?? [];
        final completedTasks = state['completedTasks'] ?? [];
        return Padding(
          padding: const EdgeInsets.all(23.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (tasks.isNotEmpty) const Text("Pending Tasks:"),
              if (tasks.isNotEmpty)
                SizedBox(
                  height: size.height * 0.2,
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return ListTile(
                        onLongPress: () =>
                            context.read<TaskBloc>().deleteTask(task.id),
                        title: Text(task.title),
                        leading: Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          value: task.isCompleted,
                          onChanged: (value) {
                            context
                                .read<TaskBloc>()
                                .toggleTaskCompletion(task.id);
                          },
                        ),
                      );
                    },
                  ),
                ),
              if (completedTasks.isNotEmpty) const Text("Completed Tasks:"),
              if (completedTasks.isNotEmpty)
                SizedBox(
                  height: size.height * 0.2,
                  child: ListView.builder(
                    itemCount: completedTasks.length,
                    itemBuilder: (context, index) {
                      final task = completedTasks[index];
                      return ListTile(
                        onLongPress: () =>
                            context.read<TaskBloc>().deleteTask(task.id),
                        title: Text(task.title),
                        leading: Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          value: task.isCompleted,
                          onChanged: (value) {
                            context
                                .read<TaskBloc>()
                                .toggleTaskCompletion(task.id);
                          },
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
