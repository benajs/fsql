import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fsql/screens/datatable.dart';

void main() {
  group("Result table tests: ", () {
    testWidgets("No records when table is empty", (WidgetTester tester) async {
      var results;
      await tester.pumpWidget(MaterialApp(home: ResultTable(results)));
      expect(find.text('No records available'), findsOneWidget);
    });

    testWidgets("Columns when there is records", (WidgetTester tester) async {
      var results = [
        ["Column", "Column"],
        ["Sample", "Test"]
      ];
      await tester.pumpWidget(MaterialApp(home: ResultTable(results)));

      expect(find.text('Column'), findsNWidgets(2));
    });

    testWidgets("Multiple records displayed", (WidgetTester tester) async {
      var results = [
        ["Column", "Column"],
        ["Sample", "Test"],
        ["Sample", "Test"],
        ["Sample", "Test"],
      ];
      await tester.pumpWidget(MaterialApp(home: ResultTable(results)));

      expect(find.text('Sample'), findsNWidgets(3));
    });
  });
}
