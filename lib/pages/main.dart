import 'package:flutter/material.dart';
import 'login.dart';

void main() => runApp(GoingTo());

class GoingTo extends StatelessWidget {
  const GoingTo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GoingTo",
      home: Login(),
    );
  }
}
