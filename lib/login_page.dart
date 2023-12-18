import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forus/bottomNavWidget.dart';
import 'package:forus/profile_page.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? _user;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    firebaseAuth.authStateChanges().listen((event) {
      _user = event;
      checkCurrentUserAndNavigate();
    });
  }

  void checkCurrentUserAndNavigate() {
    User? currentUser = firebaseAuth.currentUser;
    if (currentUser != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const bottomNavBarWidget()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login!"),
      ),
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
          onPressed: (){
            signInWithGoogle().then((userCredential) {
              if (userCredential != null) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              }
            }).catchError((error){
              print("Sign In Error: $error");
            });
          }, // Updated onPressed handler
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
