import 'package:flutter_test/flutter_test.dart';

import 'package:campus_explorer/main.dart';

void main() {
  testWidgets('campus explorer opens and its navigation works', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CampusExplorerApp());

    expect(find.text('CAMPUS EXPLORER'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Campus Explorer'), findsOneWidget);
    await tester.tap(find.text('Explore'));
    await tester.pumpAndSettle();
    expect(find.text('Campus Directory'), findsOneWidget);

    await tester.tap(find.text('About'));
    await tester.pumpAndSettle();
    expect(find.text('About Campus Explorer'), findsOneWidget);
  });
}
