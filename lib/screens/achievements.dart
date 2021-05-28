import 'dart:convert';
import 'dart:io';
import 'package:goingto_app/constants/api_path.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:goingto_app/models/accounts/achievement.dart';

class Achievements extends StatefulWidget {
  Achievements({Key? key}) : super(key: key);

  @override
  _AchievementsState createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  late Future<List> _achievementsFuture;

  Future<List> _getAchievements() async {
    final response = await http.get(Uri.parse(urlBase + urlUserAchievements));
    if (response.statusCode == HttpStatus.ok) {
      final _achievementsResponse = json.decode(response.body);
      List _achievements = _achievementsResponse
          .map((map) => Achievement.fromJson(map))
          .toList();
      return _achievements;
    } else {
      throw Exception('Falló');
    }
  }

  @override
  void initState() {
    super.initState();
    _achievementsFuture = _getAchievements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Achievements',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              )),
          Expanded(
            child: _buildAchievements(),
          )
        ],
      ),
    );
  }

  Widget _buildAchievements() {
    return FutureBuilder(
      future: _achievementsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return ListView(
            children: _listAchievements(snapshot.data),
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

  List<Widget> _listAchievements(data) {
    List<Widget> achievements = [];
    for (var achievement in data) {
      achievements.add(Card(
          margin: const EdgeInsets.only(bottom: 15.0, left: 20.0, right: 20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(achievement.name,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(achievement.text),
              ),
            ],
          )));
    }
    return achievements;
  }
}
