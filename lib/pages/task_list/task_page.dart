import 'package:eshyft_assessment/pages/task_list/task_bloc.dart';
import 'package:eshyft_assessment/pages/task_list/task_event.dart';
import 'package:eshyft_assessment/pages/task_list/task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskListPage extends StatelessWidget {
  static const routeName = 'task_list_page';

  final int _userId;

  const TaskListPage(this._userId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.textScalerOf(context).scale(14);

    return BlocProvider(
      create: (context) => TaskBloc(_userId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Task List'),
        ),
        body: BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TasksLoaded) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    state.tasks[index].title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      decoration: state.tasks[index].completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationColor: Colors.black,
                      decorationThickness: 2.0,
                      fontSize: textScaleFactor,
                    ),
                  ),
                  leading: const SizedBox(
                    width: 50,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          NetworkImage("https://source.unsplash.com/random"),
                    ),
                  ),
                );
              },
            );
          } else if (state is TaskError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Error fetching tasks. Please try again later.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TaskBloc>().add(FetchTasks());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
