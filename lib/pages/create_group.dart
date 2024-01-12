import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:forus/model/identification_system.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

Future<void> inputData(String fireGroupName, String fireDescription) async {
  String groupId =
      (await IdSystem.getUniqueId("public_data/groups/", "group_id"))
          .toString();
  DatabaseReference ref = FirebaseDatabase.instance.ref("public_data/groups/");

  await ref.push().set({
    "group_name": fireGroupName,
    "group_desc": fireDescription,
    "group_id": groupId
  });
}

class _CreateGroupState extends State<CreateGroup> {
  final groupNameController = TextEditingController();
  final groupDescController = TextEditingController();
  List<String> selectedValues = [];
  List<String> items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 40, 45, 0.612),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Group Chat",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(22, 23, 31, 1),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              SizedBox(
                width: 1200,
                child: TextField(
                  controller: groupNameController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: "Group Name",
                  ),
                ),
              ),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Choose Tags:'),
                    Theme(
                      data: ThemeData(
                        highlightColor:
                            Colors.transparent, // Remove the highlight color
                        focusColor:
                            Colors.transparent, // Remove the focus color
                      ),
                      child: TypeAheadFormField<String>(
                        textFieldConfiguration: TextFieldConfiguration(
                          decoration: InputDecoration(
                            labelText: 'Enter tag', // Add this line
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                          ),
                        ),
                        suggestionsCallback: (pattern) {
                          return items.where((item) => item
                              .toLowerCase()
                              .contains(pattern.toLowerCase()));
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        transitionBuilder:
                            (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                        onSuggestionSelected: (suggestion) {
                          setState(() {
                            selectedValues.add(suggestion);
                          });
                        },
                        noItemsFoundBuilder: (context) =>
                            const SizedBox.shrink(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: selectedValues
                          .map((value) => Chip(
                                label: Text(
                                  value,
                                  style: const TextStyle(fontSize: 11.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7.0, vertical: 1.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                labelPadding: const EdgeInsets.all(1.0),
                                visualDensity: const VisualDensity(
                                    horizontal: 0.0, vertical: -4.0),
                                deleteIcon: Transform.scale(
                                  scale: 0.7,
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                ),
                                onDeleted: () {
                                  setState(() {
                                    selectedValues.remove(value);
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 1200,
                child: TextField(
                  minLines: 6,
                  maxLines: 6,
                  controller: groupDescController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: "Tell us your thoughts!",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 1200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(6.0), // Set the border radius
                    ),
                  ),
                  onPressed: () {
                    inputData(
                        groupNameController.text, groupDescController.text);
                    groupNameController.text = "";
                    groupDescController.text = "";
                    print("Create Thread Button Pressed");
                  },
                  child: const Text("Create Thread",
                      style: TextStyle(color: Color.fromRGBO(40, 40, 45, 1))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
