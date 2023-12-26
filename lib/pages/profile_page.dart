import 'package:flutter/material.dart';
import 'package:forus/pages/edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        children: [
          Text('Profile Page',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EditProfile()));
        },
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(40, 40, 45, 0.612),
        child: const Icon(Icons.edit),
      ),
    );
  }
}
