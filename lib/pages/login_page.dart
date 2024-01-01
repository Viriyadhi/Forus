import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:forus/widget/bottom_nav.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late StreamSubscription<User?> _authSubscription;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    checkAndRoute();
  }

  void checkAndRoute() {
    _authSubscription = firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        inputData(user.uid, user.email ?? '');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const CustomBottomNav()),
        );
      }
    });
  }

  Future<void> inputData(String uid, String email) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("private_data/ids/$uid");
    await ref.set({"email": email});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _googleSignInButton(),
    );
  }

  Widget _googleSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(
          Buttons.google,
          text: "Sign In",
          onPressed: () {
            signInWithGoogle().then((userCredential) {
              checkAndRoute();
            }).catchError((error) {});
          }, // Updated onPressed handler
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  void dispose() {
    _authSubscription.cancel(); // Cancel the subscription
    super.dispose();
  }
}
