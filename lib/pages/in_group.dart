import 'dart:async';

import 'package:forus/model/auth_helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:forus/pages/chat.dart';
import 'package:forus/pages/create_chat.dart';

import '../model/thread_data.dart';

class InGroup extends StatefulWidget {
  final String groupName;
  final String groupId;

  const InGroup({Key? key, required this.groupName, required this.groupId})
      : super(key: key);

  @override
  State<InGroup> createState() => _InGroupState();
}

class _InGroupState extends State<InGroup> {
  String groupStatus = "Loading...";
  late bool isAlreadyInGroup;

  Future<void> checkData() async {
    String? curUserId = await AuthHelper.getCurrentUserId();
    List<String> userJoinedGroups = [];

    DatabaseReference userGroup =
        FirebaseDatabase.instance.ref('private_data/group_join/user$curUserId');

    try {
      DatabaseEvent event = await userGroup.once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          data.forEach((key, value) {
            userJoinedGroups.add(value['group_id'].toString());
            bool isNotJoined = !userJoinedGroups.contains(widget.groupId);

            setState(() {
              isAlreadyInGroup = !isNotJoined; //Printing True Or False
              groupStatus = isNotJoined ? "Add to MyGroup" : "Add Thread";
            });
          });
        }
      }
      if (snapshot.value == null) {
        setState(() {
          isAlreadyInGroup = false; //Printing True Or False
          groupStatus = "Add to MyGroup";
        });
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    readData();
    checkData();
  }

  Future<void> threadOnTap() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Chat(
                  chatName: "test",
                )));
  }

  Future<void> inputData() async {
    if (!isAlreadyInGroup) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Group has been added!'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Group has been added! You can now add thread to this group.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  isAlreadyInGroup = true;
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

      String? uid = await AuthHelper.getCurrentUserId();
      DatabaseReference userGroupsRef =
          FirebaseDatabase.instance.ref("private_data/group_join/user$uid");
      userGroupsRef
          .push()
          .set({"group_name": widget.groupName, "group_id": widget.groupId});
      setState(() {
        groupStatus = "Add Thread";
      });
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateChat(
                    groupName: widget.groupName,
                    groupId: widget.groupId,
                  )));
    }
  }
//Old Input Data:
  //no need to use this
  // Future<void> _inputData() async {
  //   String? uid = await AuthHelper.getCurrentUserId();
  //   DatabaseReference userGroupsRef =
  //       FirebaseDatabase.instance.ref("private_data/group_join/user$uid");
  //
  //   userGroupsRef
  //       .orderByChild("group_name")
  //       .equalTo(widget.groupName)
  //       .once()
  //       .then((DatabaseEvent event) {
  //     DataSnapshot snapshot = event.snapshot;
  //
  //     if (snapshot.value != null) {
  //       Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;
  //
  //       if (data!.isNotEmpty) {
  //         return showDialog<void>(
  //           context: context,
  //           barrierDismissible: false,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               title: const Text('You are already in this group!'),
  //               content: const SingleChildScrollView(
  //                 child: ListBody(
  //                   children: <Widget>[
  //                     Text('Grup already exists!'),
  //                   ],
  //                 ),
  //               ),
  //               actions: <Widget>[
  //                 TextButton(
  //                   child: const Text('Close'),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             );
  //           },
  //         );
  //       }
  //     } else {
  //       userGroupsRef.push().set({"group_name": widget.groupName});
  //       return showDialog<void>(
  //         context: context,
  //         barrierDismissible: false,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             content: const SingleChildScrollView(
  //               child: ListBody(
  //                 children: <Widget>[
  //                   Text('Group Added'),
  //                 ],
  //               ),
  //             ),
  //             actions: <Widget>[
  //               TextButton(
  //                 child: const Text('Close'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   });
  // }

  void readData() {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("public_data/group_chats");
    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null) {
        if (data is Map) {
          List<ThreadData> fetchedData = [];

          data.forEach((key, value) {
            fetchedData.add(ThreadData(
                title: value['name'],
                description: value['about'],
                id: value['id'],
                groupId: value['groupBelongs']));
          });

          setState(() {
            _allData = fetchedData.toList();
            _filtered = _allData;
            _filtered = _allData
                .where(
                    (data) => data.groupId.toString().contains(widget.groupId))
                .toList();
          });
        }
      }
    });
  }

  List<ThreadData> _allData = [];
  List<ThreadData> _filtered = [];

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

  Widget threadTemplate(data) {
    return GestureDetector(
      onTap: () {
        threadOnTap();
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
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Group Chat",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(22, 23, 31, 1),
        ),
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
                    Padding(
                        padding: const EdgeInsets.only(top: 22),
                        child: SizedBox(
                          height: 400,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: _filtered.length,
                            itemBuilder: (context, index) =>
                                threadTemplate(_filtered[index]),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            inputData();
          },
          label: Text(groupStatus),
          icon: const Icon(Icons.add),
        ));
  }
}
