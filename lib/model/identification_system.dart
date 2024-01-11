import 'dart:math';

import 'package:firebase_database/firebase_database.dart';

class IdSystem {
  static Future<int> getUniqueId(
      String firebasePath, String firebaseDataName) async {
    List<String> groupIds = [];
    Random random = Random();
    int newId = random.nextInt(90000) + 10000;
    DatabaseReference ref = FirebaseDatabase.instance.ref(firebasePath);

    try {
      DatabaseEvent event = await ref.once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          data.forEach((key, value) {
            groupIds.add(value[firebaseDataName].toString());
            bool unique = !groupIds.contains(newId);
            while (!unique) {
              newId = random.nextInt(90000) + 10000;
            }
            newId = newId;
          });
        }
      }
    } catch (error) {
      print('Error: $error');
    }
    return newId;
  }
}
