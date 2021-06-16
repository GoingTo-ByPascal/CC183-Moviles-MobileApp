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
  List<Country> countries = [];
  List<City> cities = [];
  City? selectedcity;
  String? selectedcategory;
  Country? selectedcountry;

  _getCountries() async {
    final response = await http.get(Uri.parse(urlBase + "countries"));
    if (response.statusCode == HttpStatus.ok) {
      final _countriesResponse = json.decode(response.body);
      List _countries =
          _countriesResponse.map((map) => Country.fromJson(map)).toList();
      for (var country in _countries) {
        countries.add(country);
      }
    } else {
      throw Exception("Falló");
    }
  }

  _getCities() async {
    final response = await http.get(
        Uri.parse(urlBase + "countries/${this.selectedcountry?.id}/cities"));
    if (response.statusCode == HttpStatus.ok) {
      final _citiesResponse = json.decode(response.body);
      List _cities = _citiesResponse.map((map) => City.fromJson(map)).toList();
      for (var city in _cities) {
        cities.add(city);
      }
    } else {
      throw Exception("Falló");
    }
  }

  @override
  void initState() {
    _getCountries();
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
              'Filter my search ${this.countries.length}',
              style: TextStyle(fontSize: 15.0, color: Colors.black),
            )),
        Padding(
            padding: const EdgeInsets.only(top: 30.0), child: _filtercountry()),
        Padding(
            padding: const EdgeInsets.only(top: 50.0, bottom: 40.0),
            child: _filtercity()),
        Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: _filtercategory()),
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

  Widget _filtercountry() {
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
        _getCities();
      },
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      items: this.countries.map((Country value) {
        return DropdownMenuItem<Country>(
          value: value,
          child: Text(value.fullName),
        );
      }).toList(),
    );
  }

  Widget _filtercity() {
    return DropdownButton<City>(
      hint: Text("Choose a city"),
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      value: selectedcity,
      onChanged: (City? newValue) {
        setState(() {
          selectedcity = newValue;
        });
      },
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      items: this.cities.map((City value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }

  Widget _filtercategory() {
    return DropdownButton<String>(
      hint: Text("Choose a category"),
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      value: selectedcategory,
      onChanged: (newValue) {
        setState(() {
          selectedcategory = newValue;
        });
      },
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      items: <String>['One', 'Two', 'Free', 'Foury']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
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
