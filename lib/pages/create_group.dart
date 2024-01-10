import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:forus/model/identification_system.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final groupNameInput = TextEditingController();
  final groupDescriptionInput = TextEditingController();

  Future<void> inputData(String fireGroupName, String fireDescription) async {
    String groupId =
        (await IdSystem.getUniqueId("public_data/groups/", "group_id"))
            .toString();
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("public_data/groups/");

    await ref.push().set({
      "group_name": fireGroupName,
      "group_desc": fireDescription,
      "group_id": groupId
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hello Ini Bikin Grup"),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: groupNameInput,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Group Name',
                      labelStyle: const TextStyle(color: Colors.black),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: groupDescriptionInput,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Description',
                      labelStyle: const TextStyle(color: Colors.black),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        if (groupNameInput.text.isEmpty ||
                            groupDescriptionInput.text.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: const Text("Input Text"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ));
                        }
                        if (groupNameInput.text.isNotEmpty &&
                            groupDescriptionInput.text.isNotEmpty) {
                          inputData(
                              groupNameInput.text, groupDescriptionInput.text);
                          groupNameInput.text = "";
                          groupDescriptionInput.text = "";
                        }
                      },
                      style: TextButton.styleFrom(
                          fixedSize: const Size(200, 50),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              side: BorderSide(color: Colors.black))),
                      child: const Text("Create Group",
                          style: TextStyle(color: Colors.black)),
                    ))
              ],
            ),
          ],
        ));
  }
}
