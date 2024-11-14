import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';

/// Bloc to manage the state and events for tasks.
///
/// This handles task-related actions like adding, deleting,
/// and toggling task completion.
class TaskBloc extends Cubit<Map<String, List<Task>>> {
  final TaskRepository taskRepository;

  TaskBloc(this.taskRepository)
      : super({'tasks': [], 'completedTasks': [], 'totalTasks': []}) {
    loadTasks();
  }

  /// Loads all tasks and splits them into completed and pending tasks.
  Future<void> loadTasks() async {
    final tasks = await taskRepository.getTasks();
    final completedTasks = tasks.where((task) => task.isCompleted).toList();
    final pendingTasks = tasks.where((task) => !task.isCompleted).toList();

    emit({
      'tasks': pendingTasks,
      'completedTasks': completedTasks,
      'totalTasks': tasks
    });
  }

  /// Adds a new task and refreshes the task lists.
  Future<void> addTask(Task task) async {
    await taskRepository.addTask(task);
    loadTasks();
  }

  /// Deletes a task and refreshes the task lists.
  Future<void> deleteTask(String id) async {
    await taskRepository.deleteTask(id);
    loadTasks();
  }

  /// Toggles the completion status of a task and refreshes the task lists.
  Future<void> toggleTaskCompletion(String id) async {
    await taskRepository.toggleTaskCompletion(id);
    loadTasks();
  }
}
