import 'package:flutter/material.dart';

class BottomNavbar {
  static BottomNavigationBar bottomNavigationBar = BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
      BottomNavigationBarItem(icon: Icon(Icons.face), label: 'My Hooman'),
      BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
    ],
  );
}
