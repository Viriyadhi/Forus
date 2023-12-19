import 'package:flutter/material.dart';
import 'package:forus/pages/navigation_thing.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: Navigation(),
  ));
}