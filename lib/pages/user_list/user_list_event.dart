abstract class UserEvent {}

class FetchUsers extends UserEvent {
  final int page;

  FetchUsers({required this.page});
}

class GoToUserTasks extends UserEvent {
  final int userId;

  GoToUserTasks(this.userId);
}
