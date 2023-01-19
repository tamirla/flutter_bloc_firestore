import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Center(
          child: Column(
            children: const [
              Text('loading'),
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
}
