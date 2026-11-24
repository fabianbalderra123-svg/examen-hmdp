import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:refaccionaria_app/main.dart';

void main() {
  testWidgets('La app arranca', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
