import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthHelper {
  static String? userIdentification;

  static Future<String?> getCurrentUserId() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      userIdentification = user.uid;
      return user.uid;
    } else {
      return null; // Return null if the user is not logged in
    }
  }

  static Future<String?> getUserEmail() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      return user.email;
    } else {
      // If the user is not logged in, return null
      return null;
    }
  }

  static Future<void> getUsername() async {
    final ref =
        FirebaseDatabase.instance.ref('private_data/ids/$userIdentification');
    final snapshot = await ref.get();
    if (snapshot.exists) {
      final dynamic data = snapshot.value;
      if (data != null &&
          data is Map<dynamic, dynamic> &&
          data.containsKey('username')) {
        print(data['username']);
      }
    }
    return;
  }

  static Future<void> sendUsername(String username, String userID) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("private_data/ids/$userID/");

    await ref.update({"username": username});
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    // Perform any additional tasks after sign out if needed
  }
}
