import 'package:flutter/material.dart';
import 'package:forus/home_page.dart';

void main() => runApp(MaterialApp(initialRoute: '/home', routes: {
      '/': (context) => const HomePage(),
      // '/:name': (context) => const HomePage(),
      // '/:name/:tag': (context) => const HomePage(),
    }));
