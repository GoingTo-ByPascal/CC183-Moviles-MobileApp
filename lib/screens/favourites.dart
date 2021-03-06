import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goingto_app/constants/api_path.dart';
import 'package:goingto_app/models/geographic/locatable.dart';
import 'package:http/http.dart' as http;

class Favourites extends StatefulWidget {
  final int userId;
  Favourites({Key? key, required this.userId}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  late Future<List> _favouritesFuture;
  late bool _fav;

  Future<List> _getFavourites() async {
    final response = await http.get(Uri.parse(
        urlBase + urlUsers + widget.userId.toString() + '/' + urlLocatables));
    if (response.statusCode == HttpStatus.ok) {
      final _favouritesResponse = json.decode(response.body);
      List _favourites =
          _favouritesResponse.map((map) => Locatable.fromJson(map)).toList();
      return _favourites;
    } else {
      throw Exception('Falló');
    }
  }

  void _addFavourite(int favId) async {
    var url = Uri.parse(urlBase +
        urlUsers +
        widget.userId.toString() +
        '/' +
        urlLocatables +
        favId.toString());

    final response = await http.post(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    print(url);
    print(response.statusCode);
    print("AGREGAO");
  }

  void _removeFavourite(int favId) async {
    final response = await http.delete(
      Uri.parse(urlBase +
          urlUsers +
          widget.userId.toString() +
          '/' +
          urlLocatables +
          'LocatableId?locatableId=' +
          favId.toString()),
    );

    print(response.statusCode);
  }

  @override
  void initState() {
    super.initState();
    _favouritesFuture = _getFavourites();
    _fav = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text(
                'Favourites',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Color(0xffFF5757)),
              )),
          Expanded(
            child: _buildFavourites(),
          )
        ],
      ),
    );
  }

  Widget _buildFavourites() {
    return FutureBuilder(
      future: _favouritesFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: _listFavourites(snapshot.data),
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

  List<Widget> _listFavourites(data) {
    List<Widget> favourites = [];
    for (var favourite in data) {
      favourites.add(
        Card(
          child: ListTile(
            title: InkWell(
              onTap: () => print(favourite.name),
              child: Text(
                favourite.name,
              ),
            ),
            subtitle: Text(
              favourite.address,
            ),
            leading: CircleAvatar(
              child: Text(favourite.name.substring(0, 1)),
            ),
            trailing: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _fav = !_fav;
                  });
                  _fav
                      ? _addFavourite(favourite.id)
                      : _removeFavourite(favourite.id);
                },
                child: _fav
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
              ),
            ),
          ),
        ),
      );
    }
    return favourites;
  }
}
