import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'auth_helper.dart';

class ChatHelper extends ChangeNotifier {
  Future<void> sendMessage(String threadId, String message) async {
    DatabaseReference userChatRef =
        FirebaseDatabase.instance.ref("chat_data/$threadId/history");
    final String currentUserId = AuthHelper.getCurrentUserId().toString();
    final String currentUserEmail = AuthHelper.getUserEmail().toString();
    userChatRef.push().set(
        {"user": currentUserId, "email": currentUserEmail, "message": message});
  }

  Future<void> readMessage(String threadId) async {
    DatabaseReference userChatRef =
        FirebaseDatabase.instance.ref("chat_data/$threadId/history");
    userChatRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;

      if (data is Map) {
        List<String> fetchedData = [];

        data.forEach((key, value) {
          fetchedData.add(value['message']);
        });
      }
    });
  }
}
