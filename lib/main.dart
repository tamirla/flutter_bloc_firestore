import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firestore_sample_app/bloc/users_bloc.dart';
import 'package:flutter_bloc_firestore_sample_app/bloc/users_repository.dart';
import 'package:flutter_bloc_firestore_sample_app/components/loader.dart';
import 'package:flutter_bloc_firestore_sample_app/home.dart';
import 'package:flutter_bloc_firestore_sample_app/login.dart';
import 'package:flutter_bloc_firestore_sample_app/services/auth_service.dart';
import 'package:flutter_bloc_firestore_sample_app/utils/log.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Directionality(
          textDirection: TextDirection.rtl,
          child: AppRouter(),
        ),
      ),
    );
  }
}

class AppRouter extends StatelessWidget {
  const AppRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, authService, child) {
      if (!authService.authStatus.initialized) {
        log('AppRouter: authStatus not initialized => Loader');
        return const Loader();
      }
      if (authService.authStatus.fbUser == null) {
        log('AppRouter: authStatus initialied, no fbUser => Login');
        return const Login();
      }

      return BlocProvider(
          create: (_) => UsersBloc(usersRepository: UsersRepository()),
          child: const Home());
    });
  }
}
