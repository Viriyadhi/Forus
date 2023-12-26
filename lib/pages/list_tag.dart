import 'package:flutter/material.dart';

class TagList extends StatefulWidget {
  const TagList({super.key});

  @override
  State<TagList> createState() => _TagListState();
}

class _TagListState extends State<TagList> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Tag List'),
      ),
    );
  }
}
