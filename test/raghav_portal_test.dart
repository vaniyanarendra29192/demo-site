// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_neelkanth_heritage/features/raghav/portal.dart';

void main() {
  testWidgets('mobile menu search and table QR navigation', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const RaghavApp());
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Authentic Pure Vegetarian'), findsOneWidget);

    await tester.tap(find.text('Menu'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'palak paneer');
    await tester.pumpAndSettle();
    expect(find.text('Palak Paneer'), findsOneWidget);
    expect(find.text('Paneer Kadai'), findsNothing);

    await tester.tap(find.text('QR'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Open Digital Menu'));
    await tester.tap(find.text('Open Digital Menu'));
    await tester.pumpAndSettle();
    expect(
      find.text('Table 03 · Your table is included when you order.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('desktop navigation scrolls to booking and validates the form', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1280, 800);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const RaghavApp());
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsNothing);
    expect(find.text('Authentic Pure Vegetarian'), findsOneWidget);

    await tester.tap(find.text('Table Booking'));
    await tester.pumpAndSettle();
    expect(
      find.text('Book Your Royal Table or Banquet').hitTestable(),
      findsOneWidget,
    );
    final send = find.text('Send on WhatsApp');
    await tester.ensureVisible(send);
    await tester.tap(send);
    await tester.pumpAndSettle();
    expect(find.text('Enter your name'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
