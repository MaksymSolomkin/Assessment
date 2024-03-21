import 'package:eshyft_assessment/locator.dart';
import 'package:eshyft_assessment/model/task.dart';
import 'package:eshyft_assessment/model/user.dart';
import 'package:eshyft_assessment/services/networking_service.dart';

class UserService {
  final NetworkingService _networkingService = locator<NetworkingService>();

  Future<List<User>> getUsers() async {
    final response = await _networkingService.get('users');
    final List<dynamic> jsonData = response as List<dynamic>;

    final List<User> userList =
        jsonData.map((user) => User.fromJson(user)).toList();
    return userList;
  }

  Future<List<Task>> getTasks(int userId) async {
    final response = await _networkingService.get('todos?userId=$userId');
    final List<dynamic> jsonData = response as List<dynamic>;

    final List<Task> tasksList =
        jsonData.map((user) => Task.fromJson(user)).toList();
    return tasksList;
  }
}
