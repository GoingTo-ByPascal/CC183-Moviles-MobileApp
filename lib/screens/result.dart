import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:goingto_app/constants/api_path.dart';
import 'package:goingto_app/models/geographic/place.dart';
import 'package:goingto_app/screens/place_info.dart';
import 'package:http/http.dart' as http;

class Result extends StatefulWidget {
  final int userId;
  final String namePlace;
  Result({Key? key, required this.userId, this.namePlace = ""})
      : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late Future<Place> _placesFuture;

  Future<Place> _getPlaces() async {
    final response =
        await http.get(Uri.parse(urlBase + "places/" + widget.namePlace));
    if (response.statusCode == HttpStatus.ok) {
      final _placesResponse = json.decode(response.body);
      Place _places = Place.fromJson(_placesResponse);
      return _places;
    } else {
      throw Exception("Falló");
    }
  }

  @override
  void initState() {
    _placesFuture = _getPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _resultsView());
  }

  Widget _resultsView() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Text(
              'Results',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Color(0xffFF5757)),
            )),
        Expanded(
          child: _buildCountries(),
        ),
      ],
    );
  }

  Widget _buildCountries() {
    return FutureBuilder(
        future: _placesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("Good");
            return Center(child: onePlace(snapshot.data));
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text("Error");
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  InkWell onePlace(data) {
    var place = data;
    return InkWell(
        onLongPress: () {
          print(place.name);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PlaceInfo(userId: widget.userId, place: place)));
        },
        child: Card(
            child: Column(children: [
          Expanded(
              child: Image.network(
            place.image,
            fit: BoxFit.fill,
          )),
          Text(
            place.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(place.locatable.address),
        ])));
  }
}
