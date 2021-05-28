import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:goingto_app/constants/api_path.dart';
import 'package:goingto_app/models/interactions/review.dart';
import 'package:http/http.dart' as http;

class PlaceReviews extends StatefulWidget {
  final int locatableId;
  PlaceReviews({Key? key, required this.locatableId}) : super(key: key);

  @override
  _PlaceReviewsState createState() => _PlaceReviewsState();
}

class _PlaceReviewsState extends State<PlaceReviews> {
  late Future<List> _reviewsFuture;

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

  @override
  void initState() {
    super.initState();
    _reviewsFuture = _getReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Color(0xff3490de),
            child: Text('Reviews',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                )),
          ),
          Expanded(
            child: _buildReviews(),
          )
        ],
      ),
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
      reviews.add(Card(
          margin: const EdgeInsets.only(bottom: 15.0, left: 20.0, right: 20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(review.comment,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          )));
    }
    return reviews;
  }
}
