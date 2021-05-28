import 'dart:convert';
import 'dart:io';
import 'package:goingto_app/constants/api_path.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:goingto_app/models/accounts/Achievement.dart';

class Achievements extends StatefulWidget {
  Achievements({Key? key}) : super(key: key);

  @override
  _AchievementsState createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  late Future<List<Achievement>> _listadoAchievement;

  Future<List<Achievement>> _getAchievements() async {
    final response = await http.get(Uri.parse(urlBase + urlUserAchievements));
    List<Achievement> achievements = [];
    if (response.statusCode == HttpStatus.ok) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(body);

      for (var item in jsonData) {
        achievements
            .add(Achievement(item["name"], item["text"], item["points"]));
      }

      return achievements;
    } else {
      throw Exception('Fallo pes :(');
    }
  }

  @override
  void initState() {
    super.initState();
    _listadoAchievement = _getAchievements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Achievements"),
          Expanded(
              child: FutureBuilder(
            future: _listadoAchievement,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                return ListView(
                  children: _listAchievements(snapshot.data),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Text("error");
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ))
        ],
      ),
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

/*
achievements.add(Card(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(achievement.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(achievement.text),
                ),
              ],
            )),
      ));
 */
/*FutureBuilder(
          future: _listadoAchievement,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return ListView(
                children: _listAchievements(snapshot.data),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("error");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
       ) */
