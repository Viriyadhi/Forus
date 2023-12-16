import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> names = [
    'For Us',
    'For Us',
    'For Us',
    'For Us',
    'For Us',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Forus',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.blueAccent,
        ),
        body: Column(
          children: names
              .map((name) => Card(
                    child: Text(name),
                  ))
              .toList(),
        ));
  }
}
