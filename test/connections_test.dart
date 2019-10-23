import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fsql/data/connectionList.dart';
import 'package:fsql/screens/home.dart';
import 'package:provider/provider.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;

  group("Connection List Tests", () {
    testWidgets('Connection List', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Provider<ConnectionList>.value(
        value: ConnectionList(),
        child: ConnectionTable(),
      )));
      expect(find.text('No Connections'), findsOneWidget);
    });
  });
}
