import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goingto_app/constants/api_path.dart';
import 'package:goingto_app/models/accounts/user.dart';
import 'package:goingto_app/screens/login/register_profile.dart';
import '../home.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late int _userId;
  late bool _hasId = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  void _postUser() async {
    var url = Uri.parse(urlBase + "/users");
    var response = await http.post(url,
        body: json.encode({
          "email": emailController.text,
          "password": passwordController.text,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    if (response.statusCode == HttpStatus.ok) {
      final jsonData = json.decode(response.body);
      _userId = jsonData["id"];
      _hasId = true;
    } else {
      _hasId = false;
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
                            _userField('Correo'),
                            SizedBox(height: 30.0),
                            _passwordField(),
                            SizedBox(height: 30.0),
                            _passwordConfirmationField(),
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

  Widget _userField(String hint) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: TextField(
          controller: emailController,
          decoration: InputDecoration(
              hintText: hint, fillColor: Colors.white, filled: true),
        ));
  }

  Widget _passwordField() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: TextField(
          obscureText: true,
          controller: passwordController,
          decoration: InputDecoration(
              hintText: "Contraseña", fillColor: Colors.white, filled: true),
        ));
  }

  Widget _passwordConfirmationField() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: TextField(
          obscureText: true,
          controller: passwordConfirmationController,
          decoration: InputDecoration(
              hintText: "Confirmar Contraseña",
              fillColor: Colors.white,
              filled: true),
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
        print(emailController.text),
        print(passwordController.text),
        print(passwordConfirmationController.text),
        if (passwordController.text == passwordConfirmationController.text &&
            passwordController.text != '' &&
            emailController.text != '')
          {
            _postUser(),
            _hasId
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterProfile(
                              userId: _userId,
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
        'SIGUIENTE',
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}
