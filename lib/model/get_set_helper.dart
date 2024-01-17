import 'package:firebase_database/firebase_database.dart';

class RoFirebaseConnect{


  static Future<List> getDataOnce(String firebasePath, String dataName) async {
    List<String> listOfData = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref(firebasePath);
    try{
      DatabaseEvent event = await ref.once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null){
        Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;
        if (data != null){
          data.forEach((key, value) {
            listOfData.add(value[dataName]);
          });
        }
      }
    } catch (error){
      print("Error: $error");
    }
    return listOfData;
  }

  static updateData(String firebasePath, String dataName, String dataValue){
    DatabaseReference userGroupsRef = FirebaseDatabase.instance.ref(firebasePath);
    userGroupsRef
        .push()
        .update({dataName: dataValue});
  }

  static setData(String firebasePath, String dataName, String dataValue){
    DatabaseReference userGroupsRef = FirebaseDatabase.instance.ref(firebasePath);
    userGroupsRef
        .push()
        .set({dataName: dataValue});
  }
}