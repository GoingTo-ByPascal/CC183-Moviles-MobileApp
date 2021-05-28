import 'package:flutter/material.dart';
import 'package:goingto_app/models/geographic/place.dart';
import 'package:goingto_app/screens/place_reviews.dart';

import 'place_tips.dart';

class PlaceInfo extends StatefulWidget {
  final Place place;
  const PlaceInfo({Key? key, required this.place}) : super(key: key);

  @override
  _PlaceInfoState createState() => _PlaceInfoState();
}

class _PlaceInfoState extends State<PlaceInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _placeView(),
    );
  }

  Widget _placeView() {
    return Column(
      children: [
        Expanded(
          flex: 15,
          child: Center(
            child: Text(widget.place.name),
          ),
        ),
        Expanded(
          flex: 35,
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40.0),
              child: Expanded(
                child: Image.network(
                  widget.place.image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 35,
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Text(widget.place.locatable!.description),
            ),
          ),
        ),
        Expanded(
          flex: 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PlaceTips(placeId: widget.place.id)));
                },
                child: Text("TIPS"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PlaceReviews(placeId: widget.place.id)));
                },
                child: Text("REVIEWS"),
              ),
            ],
          ),
        )
      ],
    );
  }
}
