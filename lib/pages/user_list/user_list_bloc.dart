import 'package:eshyft_assessment/locator.dart';
import 'package:eshyft_assessment/pages/task_list/task_page.dart';
import 'package:eshyft_assessment/pages/user_list/user_list_event.dart';
import 'package:eshyft_assessment/pages/user_list/user_list_state.dart';
import 'package:eshyft_assessment/services/navigation_service.dart';
import 'package:eshyft_assessment/services/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _userService = locator<UserService>();
  final NavigationService _navigationService = locator<NavigationService>();

  UserBloc() : super(UserLoading()) {
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final userList = await _userService.getUsers();
        emit(UserLoaded(userList));
      } catch (e) {
        emit(UserError('Failed to fetch users: $e'));
      }
    });

    on<GoToUserTasks>((event, emit) async => await _navigationService
        .navigateTo(TaskListPage.routeName, arguments: event.userId));

    add(FetchUsers());
  }
}
