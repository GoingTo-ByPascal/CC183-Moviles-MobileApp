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
  late Future<List> _placesList;

  Future<List> _getPlaces() async {
    final response = await http.get(Uri.parse(urlBase));

    if (response.statusCode == HttpStatus.ok) {
      final jsonData = json.decode(response.body);
      final _placesMap = jsonData;
      print(_placesMap);
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
    super.initState();
    _placesList = _getPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _exploreView());
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
}
