abstract class UserEvent {}

class FetchUsers extends UserEvent {}

class GoToUserTasks extends UserEvent {
  final int userId;

  GoToUserTasks(this.userId);
}
