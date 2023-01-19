import "package:flutter/material.dart";
import 'package:flutter_bloc_firestore_sample_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showLoading = false;

  void signIn() async {
    setState(() {
      showLoading = true;
    });

    var err = await Provider.of<AuthService>(context, listen: false).signIn();

    setState(() {
      showLoading = false;
    });

    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err),
          duration: const Duration(milliseconds: 300),
        ),
      );
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        key: _scaffoldKey,
        body: Container(
          child: showLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: signIn,
                  ),
                ),
          padding: const EdgeInsets.all(16),
        ));
  }
}
