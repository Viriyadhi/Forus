import 'package:flutter/material.dart';
import 'package:forus/model/card_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CardData> datas = [
    CardData(
        title: 'FG/Programming',
        description: 'Programming is fun, let\'s learn together',
        imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
    CardData(
        title: 'FG/Navy',
        description: 'Find out more about the Navy',
        imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
    CardData(
        title: 'FG/General',
        description: 'You can talk about anything here',
        imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
    CardData(
        title: 'FG/Food',
        description: 'Yummy yummy in my tummy',
        imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
    CardData(
        title: 'FG/Programming',
        description: 'Programming is fun, let\'s learn together',
        imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
    CardData(
        title: 'FG/Navy',
        description: 'Find out more about the Navy',
        imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
    CardData(
        title: 'FG/Military',
        description: 'Find out more about the Military',
        imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
    CardData(
        title: 'FG/General',
        description: 'You can talk about anything here',
        imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
    CardData(
        title: 'FG/Food',
        description: 'Yummy yummy in my tummy',
        imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
  ];

  List<CardData> _filtered = [];

  @override
  void initState() {
    _filtered = datas.toList();
    super.initState();
  }

  void _runFiltered(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        _filtered = datas;
      }
      if (keyword.isNotEmpty) {
        _filtered = datas
            .where((data) =>
                data.title.toLowerCase().contains(keyword.toLowerCase()))
            .toList();
      }
    });
  }

  Widget cardTemplate(data) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                _runFiltered(value);
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.clear),
                labelText: 'Search',
                hintText: 'Keyword',
                border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(50.0)
                    ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.greenAccent,
              child: SingleChildScrollView(
                child: Column(
                  children:
                      _filtered.map((data) => cardTemplate(data)).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}