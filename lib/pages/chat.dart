import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  final String chatName;
  const Chat({Key? key, required this.chatName}) : super(key: key);
  //TODO: Parse the chatName from in_group

  @override
  State<Chat> createState() => _ChatState();
}

Widget chatTemplate() {
  //make an avatar border with the user's profile picture, and message box on the right
  return Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
              'https://avatars.githubusercontent.com/u/81005238?v=4'),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(33, 33, 39, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "This is a messagemessagemessagemessagemessagemessagemessagemessagemessage",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget myChatTemplate() {
  //make an avatar border with the user's profile picture, and message box on the right
  return Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(24, 24, 28, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "This is a MESSAGE",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
              'https://avatars.githubusercontent.com/u/81005238?v=4'),
        ),
      ],
    ),
  );
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Group Chat",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(22, 23, 31, 1),
      ),
      body: Container(
        color: const Color.fromRGBO(40, 40, 45, 1),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        chatTemplate(),
                        chatTemplate(),
                        chatTemplate(),
                        myChatTemplate(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 65,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Type a message",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white, // Set the color to white
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
