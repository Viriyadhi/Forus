import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:forus/model/get_set_helper.dart';
import 'package:forus/model/identification_system.dart';

class CreateChat extends StatefulWidget {
  final String groupName;
  final String groupId;

  const CreateChat({Key? key, required this.groupName, required this.groupId}) : super(key: key);

  @override
  State<CreateChat> createState() => _CreateChatState();
}

class _CreateChatState extends State<CreateChat> {
  final titleController = TextEditingController();
  final aboutController = TextEditingController();
  List<String> selectedValues = [];
  List<String> items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 40, 45, 0.612),
      appBar: AppBar(
        title: const Text("Create Thread"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              SizedBox(
                width: 1200,
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: "Thread Title",
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
                  controller: aboutController,
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
                  onPressed: () async {
                    // Implement the logic to create the thread
                    // This is just a placeholder, replace it with your logic
                    print("Create Thread Button Pressed");
                    String firebasePath = 'public_data/group_chats';
                    String threadId = (await IdSystem.getUniqueId(firebasePath, "id"))
                        .toString();
                    DatabaseReference userGroupsRef = FirebaseDatabase.instance.ref(firebasePath);
                    userGroupsRef
                        .push()
                        .set({'name': titleController.text, 'about': aboutController.text, 'id': threadId});
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
