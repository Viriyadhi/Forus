import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forus/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late User? _user; // Declare user variable here

  @override
  void initState() {
    super.initState();
    // Retrieve the currently signed-in user
    _user = firebaseAuth.currentUser!;
  }

  Future<void> _signOut() async {
    await firebaseAuth.signOut();

    setState(() {
      _user = null;
    });

    // Navigate back to the login page after signing out
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile!"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              _user?.email ?? 'Email not available', // Display the user's email
              style: const TextStyle(fontSize: 18),
            ),
            TextButton(onPressed: _signOut, child: const Text("Sign Out!"))
          ],
        ),
      ),
    );
  }
}