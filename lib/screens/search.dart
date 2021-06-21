import 'package:flutter/material.dart';
import 'package:goingto_app/models/geographic/Country.dart';
import 'package:goingto_app/models/geographic/City.dart';
import 'package:goingto_app/screens/result.dart';
import 'package:goingto_app/screens/results.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:goingto_app/constants/api_path.dart';

class Search extends StatefulWidget {
  final int userId;
  Search({Key? key, required this.userId}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final nameController = TextEditingController();
  City? selectedcity;
  String? selectedcategory;
  Country? selectedcountry;

  //metodo 2
  late Future<List> _countriesFuture;
  late Future<List>? _citiesFuture;

  Future<List> _getCountries() async {
    final response = await http.get(Uri.parse(urlBase + "countries"));
    if (response.statusCode == HttpStatus.ok) {
      final _countriesResponse = json.decode(response.body);
      List _countries =
          _countriesResponse.map((map) => Country.fromJson(map)).toList();
      return _countries;
    } else {
      throw Exception("Falló");
    }
  }

  Future<List> _getCities() async {
    final response = await http.get(
        Uri.parse(urlBase + "countries/${this.selectedcountry?.id}/cities"));
    if (response.statusCode == HttpStatus.ok) {
      final _citiesResponse = json.decode(response.body);
      List _cities = _citiesResponse.map((map) => City.fromJson(map)).toList();

      return _cities;
    } else {
      throw Exception("Falló");
    }
  }

  @override
  void initState() {
    _countriesFuture = _getCountries();
    _citiesFuture = null;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 70.0, bottom: 20.0),
            child: _searchByName()),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Color(0xff34D939)),
          onPressed: () {
            _search();
          },
          child: Text("Search"),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Text(
              'Filter my search ${selectedcountry?.fullName}',
              style: TextStyle(fontSize: 15.0, color: Colors.black),
            )),
        Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: _buildCountries()),
        Padding(
            padding: const EdgeInsets.only(top: 50.0, bottom: 40.0),
            child: _buildCities()),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Color(0xff34D939)),
          onPressed: () {
            _filter();
          },
          child: Text("Filter"),
        ),
      ],
    ));
  }

  Widget _searchByName() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: TextField(
          controller: nameController,
          decoration: InputDecoration(
              icon: Icon(Icons.search),
              hintText: "Search by name",
              fillColor: Colors.white,
              filled: true),
        ));
  }

  Widget _buildCountries() {
    return FutureBuilder(
        future: _countriesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("Good");
            return DropdownButton<Country>(
              hint: Text("Choose a country"),
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              value: selectedcountry,
              onChanged: (newValue) {
                setState(() {
                  selectedcountry = newValue;
                });
                _citiesFuture = _getCities();
              },
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              items: _listCountries(snapshot.data).toList(),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text("Error");
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  List<DropdownMenuItem<Country>> _listCountries(data) {
    List<DropdownMenuItem<Country>> countries = [];
    for (var country in data) {
      countries.add(DropdownMenuItem<Country>(
          value: country, child: Text(country.fullName)));
    }
    return countries;
  }

  Widget _buildCities() {
    return FutureBuilder(
        future: _citiesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("Good");
            return DropdownButton<City>(
              hint: Text("Choose a city"),
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              value: selectedcity,
              onChanged: (newValue) {
                setState(() {
                  selectedcity = newValue;
                });
              },
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              items: _listCities(snapshot.data).toList(),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text("Error");
          }
          return DropdownButton<String>(
            hint: Text("Choose a city"),
            value: selectedcategory,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                selectedcategory = newValue!;
              });
            },
            items: <String>['Choose a country first!']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        });
  }

  List<DropdownMenuItem<City>> _listCities(data) {
    List<DropdownMenuItem<City>> cities = [];
    for (var city in data) {
      cities.add(DropdownMenuItem<City>(value: city, child: Text(city.name)));
    }
    return cities;
  }

  void _search() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Result(
                  userId: widget.userId,
                  namePlace: this.nameController.text,
                )));
  }

  void _filter() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Results(
                  userId: widget.userId,
                  cityId: this.selectedcity?.id,
                )));
  }
}
