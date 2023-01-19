import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firestore_sample_app/bloc/users_bloc.dart';
import 'package:flutter_bloc_firestore_sample_app/bloc/users_state.dart';
import 'package:flutter_bloc_firestore_sample_app/model/user.dart';

class Users extends StatelessWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
        builder: ((context, UsersState state) {
      if (state is UsersUnintialized) {
        return const Text('Press the button to reload users from firebase');
      }
      if (state is UsersLoading) {
        return _buildLoader();
      }
      if (state is UsersLoaded) {
        return _buildUsersList(state.users);
      }
      if (state is UsersLoadFailed) {
        return _buildErrorPage(state);
      }
      return const Text('Unexpected State !');
    }));
  }

  Widget _buildLoader() {
    return Material(
      child: Container(
        child: Center(
          child: Column(
            children: const [
              Text('loading...'),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: CircularProgressIndicator(),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        decoration: const BoxDecoration(color: Colors.white),
      ),
    );
  }

  Widget _buildUsersList(List<User> users) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                Text(users[index].name),
                Text(users[index].address),
                Text(users[index].phoneNumber),
              ]),
            ),
          );
        });
  }

  Padding _buildErrorPage(UsersLoadFailed state) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Center(
          child: Text('Failed to load users: ${state.error}'),
        ),
        decoration: const BoxDecoration(color: Colors.white),
      ),
    );
  }
}
