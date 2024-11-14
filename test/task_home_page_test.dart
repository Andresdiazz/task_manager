import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prueba_seek/domain/entities/task.dart';
import 'package:prueba_seek/presentation/blocs/add_cubit.dart';
import 'package:prueba_seek/presentation/blocs/task_bloc.dart';
import 'package:prueba_seek/presentation/pages/task_home_page.dart';

class MockTaskBloc extends MockCubit<Map<String, List<Task>>>
    implements TaskBloc {}

class MockAddCubit extends MockCubit<bool> implements AddCubit {}

void main() {
  late MockTaskBloc taskBloc;
  late MockAddCubit addCubit;

  setUp(() {
    taskBloc = MockTaskBloc();
    addCubit = MockAddCubit();
  });

  testWidgets('should show TextField when Add button is pressed',
      (tester) async {
    HttpOverrides.global = null;
    when(() => taskBloc.state)
        .thenReturn({'totalTasks': [], 'completedTasks': []});
    whenListen(addCubit, Stream.fromIterable([false, true]),
        initialState: false);

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<TaskBloc>.value(value: taskBloc),
            BlocProvider<AddCubit>.value(value: addCubit),
          ],
          child: TaskHomePage(taskBloc: taskBloc),
        ),
      ),
    );

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
  });
}
