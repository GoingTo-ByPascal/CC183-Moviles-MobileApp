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
    final response = await http.get(Uri.parse(urlBase));

    if (response.statusCode == HttpStatus.ok) {
      final jsonData = json.decode(response.body);
      final _placesMap = jsonData;
      List _places = _placesMap.map((map) => Place.fromMap(map)).toList();

      /*
      for (var item in jsonData) {
        _places.add(Place(
            shortName: item["shortName"],
            fullName: item["fullName"],
            image: item["image"]));
        print(item["shortName"] + " " + item["fullName"] + " " + item["image"]);
      }*/

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
    return Scaffold(body: _buildCountries());
  }

  Widget _exploreView() {
    return Center(
      child: Column(
        children: [
          Text("Explore"),
        ],
      ),
    );
  }

  Widget _buildCountries() {
    return FutureBuilder(
        future: _placesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("Good");
            print(snapshot.data);
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(place.name),
        )
      ])));
    }
    return places;
  }
}
