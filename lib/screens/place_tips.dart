import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:goingto_app/constants/api_path.dart';
import 'package:goingto_app/models/interactions/tip.dart';
import 'package:goingto_app/utils/bottom_nav_bar.dart';
import 'package:http/http.dart' as http;

class PlaceTips extends StatefulWidget {
  final int locatableId;
  PlaceTips({Key? key, required this.locatableId}) : super(key: key);

  @override
  _PlaceTipsState createState() => _PlaceTipsState();
}

class _PlaceTipsState extends State<PlaceTips> {
  late Future<List> _tipsFuture;

  final TextEditingController textController = TextEditingController();

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

  void _postTip() async {
    var url = Uri.parse(urlBase +
        "Users/2/Locatables/" +
        widget.locatableId.toString() +
        urlTips);
    var response = await http.post(url,
        body: json.encode({
          'text': this.textController.text,
        }),
        headers: {HttpHeaders.contentTypeHeader: "application/json"});
    final String responseString = response.body;
    tipFromJson(responseString);
  }

  @override
  void initState() {
    super.initState();
    _tipsFuture = _getTips();
  }

  @override
  Widget build(BuildContext context) {
    final _bottomNavBar = BottomNavBar(context: context);
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
              _createTip();
            },
            child: Text("Crear Tip"),
          ),
          Expanded(
            child: _buildTips(),
          )
        ],
      ),
      bottomNavigationBar: _bottomNavBar.bottomNavBar(),
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

  void _createTip() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Container(
                child: Card(
                  margin: const EdgeInsets.only(
                      bottom: 15.0, left: 20.0, right: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Crea un Tip',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Color(0xffFF5757)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: textController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Escribe algo'),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff34D939)),
                        onPressed: () {
                          _postTip();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text("Crear Tip"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
