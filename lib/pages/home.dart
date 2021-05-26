import 'package:flutter/material.dart';
import 'package:goingto_app/pages/explore.dart';
import 'package:goingto_app/pages/search.dart';
import 'package:goingto_app/pages/achievements.dart';
import 'package:goingto_app/pages/favourites.dart';
import 'package:goingto_app/pages/profile.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  navigate() {
    switch (_selectedIndex) {
      case 0:
        return Explore();
      case 1:
        return Favourites();
      case 2:
        return Search();
      case 3:
        return Achievements();
      case 4:
        return Profile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigate(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.flight_outlined),
            label: 'Explore',
            backgroundColor: Color(0xff3490de),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Favourites',
            backgroundColor: Color(0xff3490de),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Color(0xff3490de),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined),
            label: 'Achievements',
            backgroundColor: Color(0xff3490de),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Settings',
            backgroundColor: Color(0xff3490de),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white70,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
