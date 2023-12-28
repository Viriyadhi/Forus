import 'package:flutter/material.dart';

class InGroup extends StatefulWidget {
  const InGroup({super.key});

  @override
  State<InGroup> createState() => _InGroupState();
}

class _InGroupState extends State<InGroup> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Tag List'),
      ),
    );
  }
}
