import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goingto_app/constants/api_path.dart';
import 'package:goingto_app/screens/explore.dart';
import 'package:http/http.dart' as http;
import 'package:goingto_app/models/interactions/Tip.dart';

class CreateTip extends StatefulWidget {
  final int locatableId;
  CreateTip({Key? key, required this.locatableId}) : super(key: key);

  @override
  _CreateTipState createState() => _CreateTipState();
}

class _CreateTipState extends State<CreateTip> {
  String textoTip = "";

  void postearTip() async {
    var url = Uri.parse(urlBase +
        "Users/2/Locatables/" +
        widget.locatableId.toString() +
        "/Tips");
    var response = await http.post(url,
        body: json.encode({
          'text': this.textoTip,
        }),
        headers: {HttpHeaders.contentTypeHeader: "application/json"});
    final String responseString = response.body;
    tipFromJson(responseString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.all(32),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text(
                'Crea un tip',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Color(0xffFF5757)),
              )),
          Card(
              margin:
                  const EdgeInsets.only(bottom: 15.0, left: 20.0, right: 20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Redacta tu tip',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      onChanged: (texto) {
                        this.textoTip = texto;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Escribe algo'),
                    ),
                  ),
                ],
              )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Color(0xff34D939)),
            onPressed: () {
              postearTip();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Explore()));
            },
            child: Text("Crear Tip"),
          ),
        ],
      ),
    ));
  }
}
