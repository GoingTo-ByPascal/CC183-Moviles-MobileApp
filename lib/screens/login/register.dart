import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goingto_app/constants/api_path.dart';
import 'package:goingto_app/models/accounts/user.dart';
import '../home.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  Future<User> _postUser() async {
    var url = Uri.parse(urlBase + "/users");
    var response = await http.post(url,
        body: json.encode({
          "email": emailController.text,
          "password": passwordController.text,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    final String responseString = response.body;
    return userRegisterFromJson(responseString);
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
        passwordController.text == passwordConfirmationController.text
            ? {_postUser(), Navigator.pop(context)}
            // TODO Mejor mensaje de error
            : showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                      child: Card(
                          child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('LA CONTRASEÑA NO COINCIDE'),
                      ElevatedButton(
                          onPressed: () => {Navigator.pop(context)},
                          child: Text("ACEPTAR"))
                    ],
                  )));
                }),
      },
      child: Text(
        'REGISTRARME',
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}
