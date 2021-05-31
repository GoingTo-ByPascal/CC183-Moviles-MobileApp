import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:goingto_app/constants/api_path.dart';
import 'package:goingto_app/models/interactions/tip.dart';
import 'package:goingto_app/screens/create_tip.dart';
import 'package:http/http.dart' as http;

class PlaceTips extends StatefulWidget {
  final int locatableId;
  PlaceTips({Key? key, required this.locatableId}) : super(key: key);

  @override
  _PlaceTipsState createState() => _PlaceTipsState();
}

class _PlaceTipsState extends State<PlaceTips> {
  late Future<List> _tipsFuture;

  Future<List> _getTips() async {
    final response = await http.get(Uri.parse(
        urlBase + urlLocatables + widget.locatableId.toString() + urlTips));
    if (response.statusCode == HttpStatus.ok) {
      final _tipsResponse = json.decode(response.body);
      List _tips = _tipsResponse.map((map) => Tip.fromJson(map)).toList();
      return _tips;
    } else {
      throw Exception('Falló');
    }
  }

  @override
  void initState() {
    super.initState();
    _tipsFuture = _getTips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text(
                'Tips',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Color(0xffFF5757)),
              )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Color(0xff34D939)),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateTip(
                            locatableId: widget.locatableId,
                          )));
            },
            child: Text("Crear Tip"),
          ),
          Expanded(
            child: _buildTips(),
          )
        ],
      ),
    );
  }

  Widget _buildTips() {
    return FutureBuilder(
      future: _tipsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return ListView(
            children: _listTips(snapshot.data),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Text("Error");
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  List<Widget> _listTips(data) {
    List<Widget> tips = [];
    for (var tip in data) {
      tips.add(Card(
          margin: const EdgeInsets.only(bottom: 15.0, left: 20.0, right: 20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(tip.text,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          )));
    }
    return tips;
  }
}
