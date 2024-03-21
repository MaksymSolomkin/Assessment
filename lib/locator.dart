import 'package:eshyft_assessment/services/navigation_service.dart';
import 'package:eshyft_assessment/services/networking_service.dart';
import 'package:eshyft_assessment/services/user_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  locator.registerLazySingleton(() => NetworkingService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => NavigationService());
}
