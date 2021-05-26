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
            icon: Icon(Icons.local_airport),
            label: 'Explore',
            backgroundColor: Color(0xff2365FF),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
            backgroundColor: Color(0xff2365FF),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Color(0xff2365FF),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            label: 'Achievements',
            backgroundColor: Color(0xff2365FF),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Color(0xff2365FF),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
