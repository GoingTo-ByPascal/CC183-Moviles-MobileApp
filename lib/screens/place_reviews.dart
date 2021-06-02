import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:goingto_app/constants/api_path.dart';
import 'package:goingto_app/models/interactions/review.dart';
import 'package:goingto_app/utils/bottom_nav_bar.dart';
import 'package:goingto_app/utils/rating.dart';
import 'package:http/http.dart' as http;

class PlaceReviews extends StatefulWidget {
  final int locatableId;
  PlaceReviews({Key? key, required this.locatableId}) : super(key: key);

  @override
  _PlaceReviewsState createState() => _PlaceReviewsState();
}

class _PlaceReviewsState extends State<PlaceReviews> {
  late Future<List> _reviewsFuture;
  int _rating = 0;

  final TextEditingController commentController = TextEditingController();

  Future<List> _getReviews() async {
    final response = await http.get(Uri.parse(
        urlBase + urlLocatables + widget.locatableId.toString() + urlReviews));
    if (response.statusCode == HttpStatus.ok) {
      final _reviewsResponse = json.decode(response.body);
      List _reviews =
          _reviewsResponse.map((map) => Review.fromJson(map)).toList();
      return _reviews;
    } else {
      throw Exception('Falló');
    }
  }

  Future<Review> _postReview() async {
    String reviewedAt = DateTime.now().toString();

    var url = Uri.parse(urlBase +
        "users/2/" +
        urlLocatables +
        widget.locatableId.toString() +
        urlReviews);
    var response = await http.post(url,
        body: json.encode({
          "comment": commentController.text,
          "stars": _rating,
          "reviewedAt": reviewedAt,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    final String responseString = response.body;
    return reviewFromJson(responseString);
  }

  @override
  void initState() {
    super.initState();
    _reviewsFuture = _getReviews();
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
                'Reviews',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Color(0xffFF5757)),
              )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Color(0xff34D939)),
            onPressed: () {
              _createReview();
            },
            child: Text("Crear Review"),
          ),
          Expanded(
            child: _buildReviews(),
          )
        ],
      ),
      bottomNavigationBar: _bottomNavBar.bottomNavBar(),
    );
  }

  Widget _buildReviews() {
    return FutureBuilder(
      future: _reviewsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return ListView(
            children: _listReviews(snapshot.data),
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

  List<Widget> _listReviews(data) {
    List<Widget> reviews = [];
    for (var review in data) {
      reviews.add(
        Card(
          child: ListTile(
            title: Text(
              review.comment,
            ),
            subtitle: Text(
              review.userProfile.name + ' ' + review.userProfile.surname,
            ),
            leading: CircleAvatar(
              child: Text(review.userProfile.name.substring(0, 1)),
            ),
            trailing: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Row(
                children: _stars(review.stars),
              ),
            ),
          ),
        ),
      );
    }
    return reviews;
  }

  List<Widget> _stars(int rating) {
    List<Widget> stars = [];
    for (var i = 0; i < rating; i++) {
      stars.add(Icon(Icons.star));
    }
    return stars;
  }

  void _createReview() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            padding: EdgeInsets.symmetric(vertical: 300),
            child: Card(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Text(
                        'Crea un Review',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Color(0xffFF5757)),
                      )),
                  Card(
                      margin: const EdgeInsets.only(
                          bottom: 15.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Redacta tu Review',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              controller: commentController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Escribe algo'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Rating((rating) {
                              setState(() {
                                _rating = rating;
                              });
                            }, 5),
                          ),
                        ],
                      )),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xff34D939)),
                    onPressed: () {
                      _postReview();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text("Crear Review"),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
