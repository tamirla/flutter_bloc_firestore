import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firestore_sample_app/bloc/users_bloc.dart';
import 'package:flutter_bloc_firestore_sample_app/bloc/users_event.dart';
import 'package:flutter_bloc_firestore_sample_app/services/auth_service.dart';
import 'package:flutter_bloc_firestore_sample_app/users.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  _loadUsers(BuildContext context) {
    BlocProvider.of<UsersBloc>(context).add(LoadUsers());
  }

  _signOut(BuildContext context) async {
    var err = await Provider.of<AuthService>(context, listen: false).signOut();

    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err),
          duration: const Duration(milliseconds: 300),
        ),
      );
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  _signOut(context);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: const Center(
          child: Users(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _loadUsers(context);
          },
          child: const Icon(Icons.refresh),
        ));
  }
}

// class Home extends StatefulWidget {
//   const MyHomePage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// _loadUsers(BuildContext context) {
//   BlocProvider.of<UsersBloc>(context).add(LoadUsers());
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: const Center(
//         child: Users(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _loadUsers(context);
//         },
//         child: const Icon(Icons.refresh),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
