import 'package:eshyft_assessment/pages/task_list/task_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case TaskListPage.routeName:
      var args = settings.arguments as int;
      return MaterialPageRoute(builder: (context) => TaskListPage(args));
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
