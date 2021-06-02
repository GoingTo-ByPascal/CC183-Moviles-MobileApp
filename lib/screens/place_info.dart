import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goingto_app/constants/api_path.dart';
import 'package:goingto_app/models/geographic/locatable.dart';
import 'package:goingto_app/models/geographic/place.dart';
import 'package:goingto_app/screens/place_reviews.dart';
import 'package:http/http.dart' as http;

import 'place_tips.dart';

class PlaceInfo extends StatefulWidget {
  final Place place;
  const PlaceInfo({Key? key, required this.place}) : super(key: key);

  @override
  _PlaceInfoState createState() => _PlaceInfoState();
}

class _PlaceInfoState extends State<PlaceInfo> {
  void _addFavourite(int favId) async {
    var url =
        Uri.parse(urlBase + urlUsers + '1/' + urlLocatables + favId.toString());

    final response = await http.post(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    print(url);
    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _placeView(),
    );
  }

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
        InkWell(
          onTap: () => _addFavourite(widget.place.locatable.id),
          child: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
        Expanded(
          flex: 35,
          child: Card(
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
        ),
        Expanded(
          flex: 35,
          child: Card(
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Text(widget.place.locatable.description),
              ),
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
