import 'package:flutter/material.dart';
import 'package:forus/widget/bottom_nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: CustomBottomNav(),
  ));
}
