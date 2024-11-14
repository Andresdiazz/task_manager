import '../data/repositories/task_repository_impl.dart';
import '../data/sources/task_local_data_source.dart';
import '../presentation/blocs/task_bloc.dart';

class Dependencies {
  static TaskBloc provideTaskBloc() {
    final localDataSource = TaskLocalDataSource();
    final taskRepository = TaskRepositoryImpl(localDataSource);
    return TaskBloc(taskRepository);
  }
}
