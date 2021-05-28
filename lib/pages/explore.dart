import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:goingto_app/constants/api_path.dart';
import 'package:goingto_app/models/geographic/Place.dart';
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
                crossAxisCount: 3, children: _listarCountries(snapshot.data));
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text("Error");
          }
          return Center(child: RefreshProgressIndicator());
        });
  }

  List<Widget> _listarCountries(data) {
    List<Widget> places = [];
    for (var place in data) {
      places.add(Card(
          child: Column(children: [
        Expanded(
            child: Image.network(
          place.image,
          fit: BoxFit.fill,
        )),
        //padding: const EdgeInsets.all(8.0),
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
    return places;
  }
}
