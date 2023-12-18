import 'package:flutter/material.dart';
import 'package:forus/pages/home_page.dart';
import 'package:forus/pages/profile_page.dart';

void main() => runApp(MaterialApp(initialRoute: '/home', routes: {
      // '/': (context) => const SplashScreen(),
      '/home': (context) => const HomePage(),
      '/profile': (context) => const ProfilePage(),
    }));
