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

/* Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text(
                widget.place.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Color(0xffFF5757)),
              )),*/

  Widget _placeView() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Text(
              widget.place.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Color(0xffFF5757)),
            )),
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
              child: Text(widget.place.locatable.description),
            ),
          ),
        ),
        Expanded(
          flex: 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xff34D939)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlaceTips(
                              locatableId: widget.place.locatable.id)));
                },
                child: Text("TIPS"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xff34D939)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlaceReviews(
                              locatableId: widget.place.locatable.id)));
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
