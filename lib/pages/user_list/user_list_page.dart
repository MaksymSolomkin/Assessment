import 'package:eshyft_assessment/pages/user_list/user_list_bloc.dart';
import 'package:eshyft_assessment/pages/user_list/user_list_event.dart';
import 'package:eshyft_assessment/pages/user_list/user_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.textScalerOf(context).scale(14);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        state.users[index].name,
                        style: TextStyle(fontSize: textScaleFactor),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          state.users[index].username,
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: textScaleFactor),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "works at ${state.users[index].company.name}",
                    style: TextStyle(
                        color: Colors.blueGrey, fontSize: textScaleFactor),
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
                  trailing: const Icon(Icons.arrow_right_sharp),
                  onTap: () {
                    context
                        .read<UserBloc>()
                        .add(GoToUserTasks(state.users[index].id));
                  },
                );
              },
            );
          } else if (state is UserError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Error fetching users. Please try again later.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<UserBloc>().add(FetchUsers());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
