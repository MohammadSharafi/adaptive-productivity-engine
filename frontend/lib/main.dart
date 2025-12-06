import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'graphql/graphql_client.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/bloc/task/task_bloc.dart';
import 'data/datasources/task_remote_datasource.dart';
import 'data/repositories/task_repository_impl.dart';
import 'domain/usecases/get_tasks_usecase.dart';
import 'domain/usecases/create_task_usecase.dart';
import 'domain/usecases/complete_task_usecase.dart';
import 'domain/repositories/task_repository.dart';
import 'presentation/bloc/task/task_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  
  runApp(const FocusCraftApp());
}

class FocusCraftApp extends StatelessWidget {
  const FocusCraftApp({super.key});

  @override
  Widget build(BuildContext context) {
    final client = GraphQLService.getClient();
    final graphQLClient = client.value;

    // Initialize dependencies
    final taskRemoteDataSource = TaskRemoteDataSourceImpl(graphQLClient);
    final taskRepository = TaskRepositoryImpl(taskRemoteDataSource) as TaskRepository;
    final getTasksUseCase = GetTasksUseCase(taskRepository);
    final createTaskUseCase = CreateTaskUseCase(taskRepository);
    final completeTaskUseCase = CompleteTaskUseCase(taskRepository);

    return GraphQLProvider(
      client: client,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TaskBloc>(
            create: (_) => TaskBloc(
              getTasksUseCase: getTasksUseCase,
              createTaskUseCase: createTaskUseCase,
              completeTaskUseCase: completeTaskUseCase,
              taskRepository: taskRepository,
            )..add(const LoadTasksEvent()),
          ),
        ],
        child: MaterialApp(
          title: 'FocusCraft',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
