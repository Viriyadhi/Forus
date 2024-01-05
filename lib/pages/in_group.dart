import 'dart:async';

import 'package:forus/model/card_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:forus/widget/expandable_fab.dart';
import 'package:forus/pages/group_chat.dart';

class InGroup extends StatefulWidget {
  final String groupName;

  const InGroup({Key? key, required this.groupName}) : super(key: key);

  @override
  State<InGroup> createState() => _InGroupState();
}

class _InGroupState extends State<InGroup> {
  bool isAlreadyInGroup = false;
  late StreamSubscription<User?> _authSubscription;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> _loadData() async {
    bool result = await checkData();
    setState(() {
      isAlreadyInGroup = result;
    });
  }

  Future<bool> checkData() async {
    bool isExist = false;
    _authSubscription = _firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        DatabaseReference userGroupsRef = FirebaseDatabase.instance
            .ref("private_data/group_join/user${user.uid}");

        userGroupsRef
            .orderByChild("group_name")
            .equalTo(widget.groupName)
            .once()
            .then((DatabaseEvent event) {
          DataSnapshot snapshot = event.snapshot;

          if (snapshot.value != null) {
            Map<dynamic, dynamic>? data =
                snapshot.value as Map<dynamic, dynamic>?;

            if (data!.isNotEmpty) {
              //ada di grup
              isExist = true;
              print("ada di grup");
            }
          } else {
            //ga ada di grup
            isExist = false;
            print("ga ada di grup");
          }
        });
      }
    });
    print("value is: $isExist");
    return isExist;
  }

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

        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    readData();
    _loadData();
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  void _addToMyGroup() {
    _authSubscription = _firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        _inputData(user.uid, widget.groupName);
      }
    });
  }

  void _addThread() {
    print("Add Thread");
  }

  List<CardData> _allData = [];
  List<CardData> _filtered = [];

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

  Future<void> _inputData(String uid, String group) async {
    DatabaseReference userGroupsRef =
        FirebaseDatabase.instance.ref("private_data/group_join/user$uid");

    userGroupsRef
        .orderByChild("group_name")
        .equalTo(group)
        .once()
        .then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;

        if (data!.isNotEmpty) {
          return showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('You are already in this group!'),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Grup already exists!'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        userGroupsRef.push().set({"group_name": group});
        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Group Added'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  Widget chatTemplate() {
    //make an avatar border with the user's profile picture, and message box on the right
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                'https://avatars.githubusercontent.com/u/81005238?v=4'),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "This is a messagemessagemessagemessagemessagemessagemessagemessagemessage",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget chipTemplate() {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: Chip(
        label: const Text(
          '#Tag goes here',
          style: TextStyle(fontSize: 11.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        labelPadding: const EdgeInsets.all(1.0),
        visualDensity: const VisualDensity(horizontal: 0.0, vertical: -4.0),
      ),
    );
  }

  Widget threadTemplate() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const GroupChat()));
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
                    const Text(
                      "Thread Title Here",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        chipTemplate(),
                        chipTemplate(),
                        chipTemplate(),
                      ],
                    ),
                    chatTemplate(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String temporaryText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 40, 45, 0.612),
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Container(
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
                      onChanged: (value) {},
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
                  threadTemplate(),
                  threadTemplate(),
                  threadTemplate(),
                  threadTemplate(),
                  threadTemplate(),
                  threadTemplate(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: ExpandableFab(
        distance: 55.0,
        children: [
          isAlreadyInGroup
              ? Tooltip(
                  message: "You are already in this group!",
                  child: ActionButton(
                    onPressed: () {
                      _addToMyGroup();
                    },
                    icon: const Icon(Icons.add),
                  ),
                )
              : Tooltip(
                  message: "Add Thread",
                  child: ActionButton(
                    onPressed: () {
                      _addThread();
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
        ],
      ),
    );
  }
}
