import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper{
  static Future<String?> getCurrentUserId() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      return user.uid;
    } else {
      // If the user is not logged in, return null or handle the scenario accordingly
      return null;
    }
  }

  static Future<String?> getUserEmail() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      return user.email;
    } else {
      // If the user is not logged in, return null or handle the scenario accordingly
      return null;
    }
  }
}