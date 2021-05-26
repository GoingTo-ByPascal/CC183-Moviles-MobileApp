import 'package:flutter/material.dart';
import 'pages/login.dart';

void main() => runApp(GoingTo());

class GoingTo extends StatefulWidget {
  const GoingTo({Key? key}) : super(key: key);

  @override
  _GoingToState createState() => _GoingToState();
}

class _GoingToState extends State<GoingTo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GoingTo",
      home: Login(),
    );
  }
}