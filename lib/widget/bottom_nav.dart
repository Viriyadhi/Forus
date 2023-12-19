import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:forus/pages/discover_page.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/discover_page.dart',
      builder: (context, state) => const DiscoverPage()
    ),
  ],
);

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.pushNamed(context, '/home');
          break;
        case 1:
          Navigator.pushNamed(context, '/discover');
          break;
        case 2:
          Navigator.pushNamed(context, '/profile');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color.fromRGBO(3, 195, 154, 0.8),
      onTap: _onItemTapped,
    );
  }
}
