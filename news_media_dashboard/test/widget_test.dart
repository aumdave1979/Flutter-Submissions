// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:news_media_dashboard/main.dart';

void main() {
  testWidgets('shows the news dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const NewsDashboardApp());

    expect(find.text('News Dashboard'), findsOneWidget);
    expect(find.text('Welcome to News'), findsOneWidget);
    expect(find.text('Featured News Article'), findsOneWidget);
    expect(find.text('World'), findsOneWidget);
    expect(find.text('Sports'), findsOneWidget);
    expect(find.text('Technology'), findsOneWidget);
    expect(find.text('Latest World News'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Latest Technology News'), 300);

    expect(find.text('Latest Sports News'), findsOneWidget);
    expect(find.text('Latest Technology News'), findsOneWidget);
  });
}
