import 'package:eshyft_assessment/locator.dart';
import 'package:eshyft_assessment/pages/user_list/user_list_bloc.dart';
import 'package:eshyft_assessment/pages/user_list/user_list_page.dart';
import 'package:eshyft_assessment/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'router.dart' as router;

Future<void> main() async {
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(), // Provide your UserBloc instance here
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: router.generateRoute,
        title: 'User List Example',
        home: const UserListPage(),
        initialRoute: '/',
      ),
    );
  }
}
