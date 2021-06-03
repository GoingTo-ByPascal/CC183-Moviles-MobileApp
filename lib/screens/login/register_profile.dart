import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goingto_app/constants/api_path.dart';
import 'package:goingto_app/models/accounts/user_profile.dart';
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

  void _postUserProfile() async {
    print("HOLA");
    String _createdAt = DateTime.now().toString();
    var url = Uri.parse(urlBase + "/userprofiles");
    var response = await http.post(url,
        body: json.encode({
          "userId": widget.userId.toString(),
          "name": nameController.text,
          "surname": surnameController.text,
          "createdAt": _createdAt,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    print("Luego de request");
    if (response.statusCode == HttpStatus.ok) {
      _created = true;
    } else {
      _created = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _registerView());
  }

  Widget _registerView() {
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
                            _surnameField(),
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

  Widget _surnameField() {
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
                    })
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
}
