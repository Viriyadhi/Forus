import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:forus/model/card_data.dart';
import 'package:forus/pages/create_group.dart';
import 'package:forus/pages/list_tag.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  void readData() {
    DatabaseReference ref = FirebaseDatabase.instance.ref("public_data/groups");
    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;

      if (data is Map) {
        List<CardData> fetchedData = [];

        data.forEach((key, value) {
          fetchedData.add(CardData(
            title: value['group_name'],
            description: value['group_desc'],
            imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4',
          ));
        });

        setState(() {
          _allData = fetchedData.toList();
          _filtered = _allData;
        });
      }
    });
  }

  List<CardData> _allData = [];
  List<CardData> _filtered = [];

  @override
  void initState() {
    readData();
    super.initState();
  }

  void _runFiltered(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        _filtered = _allData;
      }
      if (keyword.isNotEmpty) {
        _filtered = _allData
            .where((data) =>
                data.title.toLowerCase().contains(keyword.toLowerCase()))
            .toList();
      }
    });
  }

  Widget cardTemplateHorizontal(data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const TagList()));
      },
      child: SizedBox(
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
      ),
    );
  }

  Widget cardTemplateVertical(data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const TagList()));
      },
      child: SizedBox(
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
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _filtered.length,
                        itemBuilder: (context, index) {
                          return cardTemplateHorizontal(_filtered[index]);
                        }),
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
                  child: SizedBox(
                    height: 400,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _filtered.length,
                      itemBuilder: (context, index) =>
                          cardTemplateVertical(_filtered[index]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateGroup()));
        },
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(40, 40, 45, 0.612),
        child: const Icon(Icons.add),
      ),
    );
  }
}
