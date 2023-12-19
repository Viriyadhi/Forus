import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forus/pages/navigation_thing.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: Navigation(),
      ),
    );
  });
}
