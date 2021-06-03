import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goingto_app/constants/api_path.dart';
import 'package:goingto_app/models/accounts/Achievement.dart';
import 'package:goingto_app/models/accounts/user_profile.dart';
import 'package:goingto_app/models/interactions/Review.dart';
import 'package:http/http.dart' as http;

// TODO Arreglar el diseño y agregar badges para que quede bonito
class Profile extends StatefulWidget {
  final int userId;
  Profile({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<UserProfile> _userProfileFuture;
  late Future<List> _userReviewsFuture;
  late Future<List> _userAchievementsFuture;
  late int _userProfileId;
  late int _reviewCount = 0;

  Future<UserProfile> _getUserProfileFuture() async {
    // TODO agregar userprofiles/ como constante
    var url = Uri.parse(urlBase + "userprofiles/" + widget.userId.toString());
    final response = await http.get(url);
    if (response.statusCode == HttpStatus.ok) {
      final _userProfileResponse = json.decode(response.body);
      UserProfile _userProfile = UserProfile.fromJson(_userProfileResponse);
      return _userProfile;
    } else {
      throw Exception('An Error ocurred while getting the UserProfile');
    }
  }

  Future<List> _getUserReviews() async {
    // TODO Chapar el user profile bien para poder leer las reviews
    var url = Uri.parse(urlBase + "userprofiles/2" + "/reviews");
    final response = await http.get(url);
    if (response.statusCode == HttpStatus.ok) {
      final _reviewsResponse = json.decode(response.body);
      List _reviews =
          _reviewsResponse.map((map) => Review.fromJson(map)).toList();
      return _reviews;
    } else {
      throw Exception(
          'An Error ocurred while getting the reviews by userprofile');
    }
  }

  Future<List> _getUserAchievements() async {
    var url = Uri.parse(
        urlBase + "users/" + widget.userId.toString() + "/achievements");
    final response = await http.get(url);
    if (response.statusCode == HttpStatus.ok) {
      final _achievementsresponse = json.decode(response.body);
      List _achievements = _achievementsresponse
          .map((map) => Achievement.fromJson(map))
          .toList();
      return _achievements;
    } else {
      throw Exception('An Error ocurred while getting the achievements');
    }
  }

  @override
  void initState() {
    _userProfileFuture = _getUserProfileFuture();
    _userReviewsFuture = _getUserReviews();
    _userAchievementsFuture = _getUserAchievements();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  maxRadius: 60,
                  foregroundImage: AssetImage('assets/guys.jpg'),
                ),
              ),
            ),
            _buildUserProfile(),
            Row(mainAxisSize: MainAxisSize.min, children: [
              Text("Reviews $_reviewCount"),
              Text(" Puntos:{getUserPoints}")
            ]),
            Expanded(flex: 1, child: _buildUserAchievements()),
            Expanded(flex: 1, child: _buildUserReviews())
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return FutureBuilder(
      future: _userProfileFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _userProfileId = snapshot.data.id;
          return Text(
            snapshot.data.name + " " + snapshot.data.surname,
            style: TextStyle(fontSize: 20),
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

  Widget _buildUserReviews() {
    return FutureBuilder(
        future: _userReviewsFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView(children: _reviewList(snapshot.data));
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text("Error");
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _buildUserAchievements() {
    return FutureBuilder(
      future: _userAchievementsFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return GridView.count(
              crossAxisCount: 5, children: _achievementList(snapshot.data));
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

  List<Widget> _achievementList(data) {
    List<Widget> _achievements = [];
    for (var achievement in data) {
      _achievements.add(Card(child: Text(achievement.name)));
    }
    return _achievements;
  }

  List<Widget> _reviewList(data) {
    List<Widget> _reviews = [];
    for (var review in data) {
      _reviews.add(Card(
          child: Column(children: [
        Text(review.locatable.name),
      ])));
    }
    _reviewCount = _reviews.length;
    return _reviews;
  }
}
