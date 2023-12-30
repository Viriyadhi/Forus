import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class InGroup extends StatefulWidget {
  final String groupName;

  const InGroup({Key? key, required this.groupName}) : super(key: key);

  @override
  State<InGroup> createState() => _InGroupState();
}

class _InGroupState extends State<InGroup> {
  late StreamSubscription<User?> _authSubscription;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _authSubscription.cancel(); // Cancel the subscription
    super.dispose();
  }

  void _addToMyGroup() {
    _authSubscription = _firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        _inputData(user.uid, widget.groupName);
      }
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Group has been added!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Grup has been added!'),
                Text('Click on the button below to go to the group!'),
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
            TextButton(
              child: const Text('Go to group'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _inputData(String uid, String group) async {
    DatabaseReference userGroupsRef =
        FirebaseDatabase.instance.ref("private_data/ids/$uid/groups");

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
      }
    }).catchError((error) {
      print("Error retrieving data: $error");
    });
  }

  String temporaryText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                _addToMyGroup();
              },
              child: const Text('Add to The fuck'),
            ),
          ],
        ),
      ),
    );
  }
}
