import 'package:eshyft_assessment/locator.dart';
import 'package:eshyft_assessment/pages/task_list/task_event.dart';
import 'package:eshyft_assessment/pages/task_list/task_state.dart';
import 'package:eshyft_assessment/services/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final UserService _userService = locator<UserService>();

  final int _userId;

  TaskBloc(this._userId) : super(TaskLoading()) {
    on<FetchTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final taskList = await _userService.getTasks(_userId);
        emit(TasksLoaded(taskList));
      } catch (e) {
        emit(TaskError('Failed to fetch tasks: $e'));
      }
    });

    add(FetchTasks());
  }
}
