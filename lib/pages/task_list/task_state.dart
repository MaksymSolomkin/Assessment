import 'package:eshyft_assessment/model/task.dart';

abstract class TaskState {}

class TaskLoading extends TaskState {}

class TasksLoaded extends TaskState {
  final List<Task> tasks;

  TasksLoaded(this.tasks);
}

class TaskError extends TaskState {
  final String error;

  TaskError(this.error);
}
