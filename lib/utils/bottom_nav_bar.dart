import 'package:flutter/material.dart';
import 'package:goingto_app/screens/home.dart';

class BottomNavBar {
  BuildContext context;

  BottomNavBar({
    required this.context,
  });

  Widget bottomNavBar() {
    return BottomNavigationBar(
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
          label: 'Profile',
          backgroundColor: Color(0xff3490de),
        ),
      ],
      currentIndex: 2,
      selectedItemColor: Colors.white70,
      unselectedItemColor: Colors.black,
      onTap: _navigate,
    );
  }

  void _navigate(int index) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Home(navCoord: index)));
  }
}
