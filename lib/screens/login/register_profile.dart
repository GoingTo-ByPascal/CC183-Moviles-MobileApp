import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goingto_app/constants/api_path.dart';
import 'package:goingto_app/models/accounts/user_profile.dart';
import 'package:goingto_app/models/geographic/Country.dart';
import 'package:goingto_app/screens/home.dart';
import 'package:http/http.dart' as http;

class RegisterProfile extends StatefulWidget {
  final int userId;
  RegisterProfile({Key? key, required this.userId}) : super(key: key);
  @override
  _RegisterProfileState createState() => _RegisterProfileState();
}

class _RegisterProfileState extends State<RegisterProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  late bool _created = false;
  DateTime? _selectedDate;
  Country? selectedcountry;
  String? selectedgender;
  late Future<List> _countriesFuture;

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

  void _postUserProfile() {
    String _createdAt = DateTime.now().toString();
    DateTime datito = new DateTime(
        _selectedDate!.year, _selectedDate!.month, _selectedDate!.day);
    var url = Uri.parse(urlBase + "/userprofiles");
    http.post(url,
        body: json.encode({
          "userId": widget.userId,
          "name": nameController.text,
          "surname": surnameController.text,
          "birthDate": datito.toString(),
          "gender": selectedgender,
          "countryId": selectedcountry?.id,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }).then((response) {
      print("Luego de request");
      if (response.statusCode == 204) {
        _created = true;
      } else {
        _created = false;
      }
      _created
          ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(
                        userId: widget.userId,
                        navCoord: 2,
                      )))
          // TODO Mensaje de espera el request
          : showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(
                    child: Card(
                        child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Espere unos segundos por favor...'),
                    ElevatedButton(
                        onPressed: () => {Navigator.pop(context)},
                        child: Text("ACEPTAR"))
                  ],
                )));
              });
    });
  }

  @override
  void initState() {
    _countriesFuture = _getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _registerView(context));
  }

  Widget _registerView(BuildContext context) {
    return Container(
      color: Color(0xff3490de),
      child: Column(
        children: [
          // Primer hijo:imagen de GoingTo
          Expanded(
            flex: 18,
            child: Center(
              child: Container(
                  child: Image(image: AssetImage('assets/logotrans.png'))),
            ),
          ),
          Expanded(
            flex: 90,
            child: Center(
              child: Container(
                // Diseño del rectángulo blanco
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Widgets dentro del rectangulo blanco
                  children: [
                    Expanded(
                      flex: 90,
                      child: Container(
                        child: Column(
                          children: [
                            _nameField(),
                            SizedBox(height: 30.0),
                            _surnameField(context),
                            SizedBox(height: 30.0),
                            Text("Birthday: "),
                            SizedBox(height: 10.0),
                            _dateButton(context),
                            SizedBox(height: 30.0),
                            _buildgenders(),
                            SizedBox(height: 30.0),
                            _buildCountries(),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        child: _registerButton(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameField() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: TextField(
          controller: nameController,
          decoration: InputDecoration(
              hintText: 'Name', fillColor: Colors.white, filled: true),
        ));
  }

  Widget _surnameField(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: TextField(
          controller: surnameController,
          decoration: InputDecoration(
              hintText: "Surname", fillColor: Colors.white, filled: true),
        ));
  }

  Widget _dateButton(context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.deepPurpleAccent),
      child: Text("Choose a date"),
      onPressed: () {
        showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime.now())
            .then((date) {
          setState(() {
            _selectedDate = date;
          });
        });
      },
    );
  }

  Widget _registerButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: Color(0xffFF5757),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
      onPressed: () => {
        if (nameController.text != '' && surnameController.text != '')
          {
            _postUserProfile(),
            print(_created.toString()),
          }
        else
          {
            // TODO Mejor mensaje de error por contraseña diferente
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                      child: Card(
                          child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('ERROR EN INGRESO DE DATOS'),
                      ElevatedButton(
                          onPressed: () => {Navigator.pop(context)},
                          child: Text("ACEPTAR"))
                    ],
                  )));
                }),
          },
      },
      child: Text(
        'REGISTRARME',
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
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

  Widget _buildgenders() {
    return DropdownButton<String>(
      value: selectedgender,
      hint: Text("Choose a gender"),
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
          selectedgender = newValue!;
        });
      },
      items: <String>['Male', 'Female']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
