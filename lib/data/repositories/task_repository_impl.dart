import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../sources/task_local_data_source.dart';
import '../models/task_model.dart'; // Importa TaskModel para la conversión

/// Task repository implementation that interfaces with a data source.
///
/// This class implements `TaskRepository` to fetch, add, and delete tasks
/// while isolating data management from other parts of the application.
class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<List<Task>> getTasks() async => localDataSource.getTasks();

  /// Adds a task by converting it to a TaskModel and passing it to the data source.
  @override
  Future<void> addTask(Task task) async {
    final taskModel = TaskModel(
        id: task.id, title: task.title, isCompleted: task.isCompleted);
    await localDataSource.addTask(taskModel);
  }

  @override
  Future<void> deleteTask(String id) async => localDataSource.deleteTask(id);

  @override
  Future<void> toggleTaskCompletion(String id) async =>
      localDataSource.toggleTaskCompletion(id);
}
