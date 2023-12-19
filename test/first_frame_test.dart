import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forus/widget/bottom_nav.dart';

void main() {
  testWidgets('Must be able to trigger a first frame',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: CustomBottomNav(),
      ),
    );
  });
}
