import 'package:flutter/material.dart';
import 'package:forus/model/card_data.dart';
import 'package:firebase_database/firebase_database.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  Future<void> inputData(String fireGroupName, String fireDescription) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("public_data/group");

    await ref.set({"group_name": fireGroupName, "group_desc": fireDescription});
  }

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

  Widget cardTemplateHorizontal(data) {
    return SizedBox(
      height: 200,
      width: 150,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardTemplateVertical(data) {
    return SizedBox(
      height: 80,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
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
                const Text(
                  'Hello Here are today\'s trending topics!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _filtered
                          .map((data) => cardTemplateHorizontal(data))
                          .toList(),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Text(
                    textAlign: TextAlign.left,
                    'Find Out More',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: SingleChildScrollView(
                    child: Column(
                      children: _filtered
                          .map((data) => cardTemplateVertical(data))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(40, 40, 45, 0.612),
        child: const Icon(Icons.add),
      ),
    );
  }
}
