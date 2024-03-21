import 'package:eshyft_assessment/model/user.dart';

abstract class UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;

  UserLoaded(this.users);
}

class UserError extends UserState {
  final String error;

  UserError(this.error);
}
