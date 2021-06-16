import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:goingto_app/constants/api_path.dart';
import 'package:goingto_app/models/geographic/City.dart';
import 'package:goingto_app/models/geographic/place.dart';
import 'package:goingto_app/screens/place_info.dart';
import 'package:http/http.dart' as http;

class Results extends StatefulWidget {
  final int userId;
  final int? cityId;
  Results({Key? key, required this.userId, this.cityId}) : super(key: key);

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  late Future<List> _placesFuture;

  Future<List> _getPlaces() async {
    final response =
        await http.get(Uri.parse(urlBase + "cities/${widget.cityId}/places"));
    if (response.statusCode == HttpStatus.ok) {
      final _placesResponse = json.decode(response.body);
      List _places = _placesResponse.map((map) => Place.fromJson(map)).toList();
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
    return Scaffold(body: _exploreView());
  }

  Widget _exploreView() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Text(
              'Explore',
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
            return GridView.count(
                crossAxisCount: 2, children: _listPlaces(snapshot.data));
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text("Error");
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  List<Widget> _listPlaces(data) {
    List<Widget> places = [];
    for (var place in data) {
      places.add(InkWell(
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
        ])),
      ));
    }
    return places;
  }
}
