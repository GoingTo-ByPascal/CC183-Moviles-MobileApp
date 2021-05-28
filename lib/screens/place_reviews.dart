import 'package:flutter/material.dart';

class PlaceReviews extends StatefulWidget {
  final int placeId;
  PlaceReviews({Key? key, required this.placeId}) : super(key: key);

  @override
  _PlaceReviewsState createState() => _PlaceReviewsState();
}

class _PlaceReviewsState extends State<PlaceReviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('PLACE ID IS: ' +
            widget.placeId.toString() +
            '(variable) - USAR EN EL API DE GOINGTO Y RECIBIR REVIEWS'),
      ),
    );
  }
}
