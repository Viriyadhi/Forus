import 'package:flutter/material.dart';
import 'package:forus/model/auth_helper.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final editUsernameController = TextEditingController();
  String? uid;

  Future<void> _loadUserData() async {
    String? userId = await AuthHelper.getCurrentUserId();
    setState(() {
      uid = userId ?? "Loading..";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: editUsernameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'username',
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
                      AuthHelper.sendUsername(
                          editUsernameController.text.toString(),
                          uid ?? "tempuser");
                    },
                    style: TextButton.styleFrom(
                        fixedSize: const Size(200, 50),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            side: BorderSide(color: Colors.black))),
                    child: const Text("Save",
                        style: TextStyle(color: Colors.black)),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
