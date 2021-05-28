import 'package:flutter/material.dart';

class PlaceTips extends StatefulWidget {
  final int placeId;
  PlaceTips({Key? key, required this.placeId}) : super(key: key);

  @override
  _PlaceTipsState createState() => _PlaceTipsState();
}

class _PlaceTipsState extends State<PlaceTips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('PLACE ID IS: ' +
            widget.placeId.toString() +
            '(variable) - USAR EN EL API DE GOINGTO Y RECIBIR TIPS'),
      ),
    );
  }
}
