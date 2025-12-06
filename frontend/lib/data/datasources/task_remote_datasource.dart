import 'package:graphql_flutter/graphql_flutter.dart';
import '../../core/error/failures.dart';
import '../../core/utils/retry_helper.dart';
import '../../graphql/queries.dart';
import '../../graphql/mutations.dart';
import '../models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getTasks({String? status, int? limit, int? offset});
  Future<TaskModel> getTaskById(String id);
  Future<TaskModel> createTask(Map<String, dynamic> input);
  Future<TaskModel> updateTask(String id, Map<String, dynamic> input);
  Future<TaskModel> completeTask(String id);
  Future<void> deleteTask(String id);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final GraphQLClient client;

  TaskRemoteDataSourceImpl(this.client);

  @override
  Future<List<TaskModel>> getTasks({String? status, int? limit, int? offset}) {
    return RetryHelper.retry(
      operation: () async {
        try {
          final result = await client.query(QueryOptions(
            document: gql(GraphQLQueries.getTasks),
            variables: {
              if (status != null) 'status': status,
              if (limit != null) 'limit': limit,
              if (offset != null) 'offset': offset,
            },
          ));

          if (result.hasException) {
            throw ServerFailure(
              result.exception?.graphqlErrors.first.message ?? 'Unknown error',
            );
          }

          final tasks = (result.data?['tasks'] as List<dynamic>?)
                  ?.map((json) => TaskModel.fromJson(json))
                  .toList() ??
              [];

          return tasks;
        } catch (e) {
          if (e is Failure) rethrow;
          throw NetworkFailure('Failed to fetch tasks: ${e.toString()}');
        }
      },
      retryIf: (error) => error is NetworkFailure,
    );
  }

  @override
  Future<TaskModel> getTaskById(String id) {
    return RetryHelper.retry(
      operation: () async {
        try {
          final result = await client.query(QueryOptions(
            document: gql(GraphQLQueries.getTask),
            variables: {'id': id},
          ));

          if (result.hasException) {
            throw ServerFailure(
              result.exception?.graphqlErrors.first.message ?? 'Unknown error',
            );
          }

          if (result.data?['task'] == null) {
            throw NotFoundFailure('Task not found');
          }

          return TaskModel.fromJson(result.data!['task']);
        } catch (e) {
          if (e is Failure) rethrow;
          throw NetworkFailure('Failed to fetch task: ${e.toString()}');
        }
      },
    );
  }

  @override
  Future<TaskModel> createTask(Map<String, dynamic> input) {
    return RetryHelper.retry(
      operation: () async {
        try {
          final result = await client.mutate(MutationOptions(
            document: gql(GraphQLMutations.createTask),
            variables: {'input': input},
          ));

          if (result.hasException) {
            throw ServerFailure(
              result.exception?.graphqlErrors.first.message ?? 'Unknown error',
            );
          }

          return TaskModel.fromJson(result.data!['createTask']);
        } catch (e) {
          if (e is Failure) rethrow;
          throw NetworkFailure('Failed to create task: ${e.toString()}');
        }
      },
    );
  }

  @override
  Future<TaskModel> updateTask(String id, Map<String, dynamic> input) {
    return RetryHelper.retry(
      operation: () async {
        try {
          final result = await client.mutate(MutationOptions(
            document: gql(GraphQLMutations.updateTask),
            variables: {'id': id, 'input': input},
          ));

          if (result.hasException) {
            throw ServerFailure(
              result.exception?.graphqlErrors.first.message ?? 'Unknown error',
            );
          }

          return TaskModel.fromJson(result.data!['updateTask']);
        } catch (e) {
          if (e is Failure) rethrow;
          throw NetworkFailure('Failed to update task: ${e.toString()}');
        }
      },
    );
  }

  @override
  Future<TaskModel> completeTask(String id) {
    return RetryHelper.retry(
      operation: () async {
        try {
          final result = await client.mutate(MutationOptions(
            document: gql(GraphQLMutations.completeTask),
            variables: {'id': id},
          ));

          if (result.hasException) {
            throw ServerFailure(
              result.exception?.graphqlErrors.first.message ?? 'Unknown error',
            );
          }

          return TaskModel.fromJson(result.data!['completeTask']);
        } catch (e) {
          if (e is Failure) rethrow;
          throw NetworkFailure('Failed to complete task: ${e.toString()}');
        }
      },
    );
  }

  @override
  Future<void> deleteTask(String id) {
    return RetryHelper.retry(
      operation: () async {
        try {
          final result = await client.mutate(MutationOptions(
            document: gql(GraphQLMutations.deleteTask),
            variables: {'id': id},
          ));

          if (result.hasException) {
            throw ServerFailure(
              result.exception?.graphqlErrors.first.message ?? 'Unknown error',
            );
          }

          if (result.data?['deleteTask'] != true) {
            throw ServerFailure('Failed to delete task');
          }
        } catch (e) {
          if (e is Failure) rethrow;
          throw NetworkFailure('Failed to delete task: ${e.toString()}');
        }
      },
    );
  }
}

