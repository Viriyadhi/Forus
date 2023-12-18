import 'package:flutter/material.dart';
import 'package:forus/model/card_data.dart';
import 'package:forus/widget/bottom_nav.dart';
import 'package:forus/widget/custom_app_bar.dart';

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

  Widget cardTemplate(datas) {
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
                CircleAvatar(
                  backgroundImage: NetworkImage(datas.imagePath),
                  radius: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      datas.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      datas.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
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
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.clear),
                labelText: 'Outlined',
                hintText: 'hint text',
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
                  children: datas.map((data) => cardTemplate(data)).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
