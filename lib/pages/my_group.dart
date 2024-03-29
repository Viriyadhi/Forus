import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:forus/model/card_data.dart';
import 'package:forus/pages/in_group.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription<User?> _authSubscription;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  void dispose() {
    _authSubscription.cancel(); // Cancel the subscription
    super.dispose();
  }

  void readData() {
    _authSubscription = _firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        String uid = user.uid;
        DatabaseReference ref =
            FirebaseDatabase.instance.ref("private_data/group_join/user$uid");
        ref.onValue.listen((DatabaseEvent event) {
          final data = event.snapshot.value;

          if (data != null) {
            if (data is Map) {
              List<CardData> fetchedData = [];

              data.forEach((key, value) {
                fetchedData.add(CardData(
                  title: value['group_name'],
                  description: 'Contoh',
                  id: value['group_id'],
                  imagePath:
                      'https://avatars.githubusercontent.com/u/81005238?v=4',
                ));
              });

              setState(() {
                datas = fetchedData.toList();
                _filtered = datas;
              });
            }
          }
        });
      }
    });
  }

  List<CardData> datas = [];
  List<CardData> _filtered = [];

  @override
  void initState() {
    super.initState();
    readData();
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InGroup(
                      groupName: data.title,
                      groupId: data.id,
                    )));
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
