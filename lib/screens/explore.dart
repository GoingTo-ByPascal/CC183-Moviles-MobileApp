import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:goingto_app/constants/api_path.dart';
import 'package:goingto_app/models/geographic/place.dart';
import 'package:goingto_app/screens/place_info.dart';
import 'package:http/http.dart' as http;

class Explore extends StatefulWidget {
  Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  late Future<List> _placesFuture;

  Future<List> _getPlaces() async {
    final response = await http.get(Uri.parse(urlBase + urlPlaces));
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
        Container(
          width: MediaQuery.of(context).size.width,
          color: Color(0xff3490de),
          child: Text('Explore',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              )),
        ),
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
                crossAxisCount: 3, children: _listCountries(snapshot.data));
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text("Error");
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  List<Widget> _listCountries(data) {
    List<Widget> places = [];
    for (var place in data) {
      places.add(InkWell(
        onLongPress: () {
          print(place.name);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PlaceInfo(place: place)));
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
