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
        title: 'Programming',
        description: 'Programming is fun, let\'s learn together',
        imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
    CardData(
        title: 'Navy',
        description: 'Find out more about the Navy',
        imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
    CardData(
        title: 'General',
        description: 'You can talk about anything here',
        imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
    CardData(
        title: 'Food',
        description: 'Yummy yummy in my tummy',
        imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
    CardData(
        title: 'Programming',
        description: 'Programming is fun, let\'s learn together',
        imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
    CardData(
        title: 'Navy',
        description: 'Find out more about the Navy',
        imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
    CardData(
        title: 'Military',
        description: 'Find out more about the Military',
        imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
    CardData(
        title: 'General',
        description: 'You can talk about anything here',
        imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
    CardData(
        title: 'Food',
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

  Widget cardTemplateGrid(data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(          
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 40, 45, 0.612),
      body: Container(
        color: const Color.fromRGBO(40, 40, 45, 100),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: SizedBox(
                height: 70,
                child: TextField(
                  onChanged: (value) {
                    _runFiltered(value);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: const Icon(Icons.clear),
                    labelText: 'Search',
                    hintText: 'Keyword',
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5 / 2,
                  children:
                      _filtered.map((data) => cardTemplateGrid(data)).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
