import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goingto_app/constants/api_path.dart';
import 'package:goingto_app/models/geographic/locatable.dart';
import 'package:http/http.dart' as http;

class Favourites extends StatefulWidget {
  Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  late Future<List> _favouritesFuture;

  Future<List> _getFavourites() async {
    final response =
        await http.get(Uri.parse(urlBase + urlUsers + '1/' + urlLocatables));
    if (response.statusCode == HttpStatus.ok) {
      final _favouritesResponse = json.decode(response.body);
      List _favourites =
          _favouritesResponse.map((map) => Locatable.fromJson(map)).toList();
      return _favourites;
    } else {
      throw Exception('Falló');
    }
  }

  void _deleteFavourite(int favId) async {
    final response = await http.delete(
      Uri.parse(urlBase +
          urlUsers +
          '1/' +
          urlLocatables +
          'LocatableId?locatableId=' +
          favId.toString()),
    );

    print(urlBase + urlUsers + '1/' + urlLocatables + favId.toString());
    print(response.statusCode);
  }

  @override
  void initState() {
    super.initState();
    _favouritesFuture = _getFavourites();
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
            title: Text(
              favourite.name,
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
                  print(favourite.id);
                  _deleteFavourite(favourite.id);
                },
                child: Icon(
                  Icons.favorite,
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
