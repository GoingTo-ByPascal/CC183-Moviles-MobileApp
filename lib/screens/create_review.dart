import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goingto_app/models/interactions/review.dart';
import 'package:http/http.dart' as http;

class CreateReview extends StatefulWidget {
  CreateReview({Key? key}) : super(key: key);

  @override
  _CreateReviewState createState() => _CreateReviewState();
}

Future<Review> createReview(String comment, int stars) async {
  final String apiUrl =
      "https://goingto-api.azurewebsites.net/api/Users/2/Locatables/7/Reviews";

  String reviewedAt = DateTime.now().toString();

  var response = await http.post(Uri.parse(apiUrl),
      body: json.encode({
        "comment": comment,
        "stars": stars,
        "reviewedAt": reviewedAt,
      }),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });

  /*print("Luego del supuesto post");
  print("DATA POSTEADA:");
  var data = response.bodyBytes;
  print(data);

  print("Codigo de status");
  print(response.statusCode.toString());*/

  if (response.statusCode == HttpStatus.ok) {
    print("Primero del if");
    final String responseString = response.body;
    print("Dentro del if");

    return reviewFromJson(responseString);
  } else {
    throw Exception("Falló");
  }
}

class _CreateReviewState extends State<CreateReview> {
  late Review _review = Review(comment: "placehholder", stars: 5);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
            ),
            TextField(
              controller: jobController,
            ),
            SizedBox(
              height: 32,
            ),
            Text(
                "The review ${_review.comment}, ${_review.stars} is created successfully at time ${_review.reviewedAt}"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("presionó");
          final String comment = nameController.text;
          final int stars = int.parse(jobController.text);

          print("Datos recibidos de la app: ");
          print(comment);
          print(stars);

          print("pre func{");
          final Review review = await createReview(comment, stars);
          print("}post func");
          print(review);

          setState(() {
            _review = review;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
