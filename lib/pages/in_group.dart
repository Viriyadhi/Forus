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

  Future<void> _inputData(String uid, String group) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("private_data/ids/$uid/groups");
    // ref.onValue.listen((DatabaseEvent event) {
    //   final groupData = event.snapshot.value;
    // });
    await ref.push().set({"group_name": group});
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
              child: const Text("Add To MyGroup"),
            ),
          ],
        ),
      ),
    );
  }
}
