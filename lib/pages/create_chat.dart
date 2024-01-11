import 'package:flutter/material.dart';

class CreateChat extends StatefulWidget {
  final String groupName;
  const CreateChat({Key? key, required this.groupName}) : super(key: key);

  @override
  State<CreateChat> createState() => _CreateChatState();
}

class _CreateChatState extends State<CreateChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Thread"),
      ),
      body: const Center(
        child: Text("Create Thread"),
      ),
    );
  }
}
