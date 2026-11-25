import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_neelkanth_heritage/core/router/app_router.dart';

void main() {
  testWidgets(
    'Narrow Android shows the full entrance while iOS keeps its overlay',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(360, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final router = AppRouter();
      addTearDown(router.dispose);

      await tester.pumpWidget(
        MaterialApp.router(routerConfig: router.config()),
      );
      await tester.pumpAndSettle();
      final hero = find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.semanticLabel == 'Architectural render of the entrance gate',
      );
      final isAndroid =
          Theme.of(tester.element(hero)).platform == TargetPlatform.android;
      expect(
        tester.widget<Image>(hero).fit,
        isAndroid ? BoxFit.contain : BoxFit.cover,
      );
      if (isAndroid) {
        final size = tester.getSize(hero);
        expect(size.width / size.height, closeTo(1632 / 861, 0.001));
      }
    },
    variant: const TargetPlatformVariant({
      TargetPlatform.android,
      TargetPlatform.iOS,
    }),
  );

  testWidgets('Desktop navigation, plan selection and brochure viewer', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1440, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final router = AppRouter();
    addTearDown(router.dispose);

    await tester.pumpWidget(MaterialApp.router(routerConfig: router.config()));
    await tester.pumpAndSettle();
    expect(find.text('The Divine\nElegance'), findsOneWidget);

    await tester.tap(find.text('View Brochure'));
    await tester.pumpAndSettle();
    expect(find.text('1 / 12'), findsOneWidget);
    await tester.tap(find.byTooltip('Next page'));
    await tester.pumpAndSettle();
    expect(find.text('2 / 12'), findsOneWidget);
    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Floor Plans'));
    await tester.pumpAndSettle();
    expect(find.text('3 BHK Grand Residence'), findsOneWidget);
    await tester.tap(find.widgetWithText(ChoiceChip, '2 BHK · Blocks C & D'));
    await tester.pumpAndSettle();
    expect(find.text('15′ 3″ × 10′'), findsOneWidget);
    expect(router.currentUrl, contains('unit=2bhk-cd'));

    await tester.tap(find.byTooltip('Zoom in on 2 BHK Residence'));
    await tester.pumpAndSettle();
    final viewer = tester.widget<InteractiveViewer>(
      find.byType(InteractiveViewer),
    );
    final transform = viewer.transformationController!;
    expect(transform.value.getMaxScaleOnAxis(), 1);
    await tester.tap(find.byTooltip('Zoom in'));
    await tester.pumpAndSettle();
    expect(transform.value.getMaxScaleOnAxis(), closeTo(1.5, 0.001));
    await tester.tap(find.byTooltip('Zoom out'));
    await tester.pumpAndSettle();
    expect(transform.value.getMaxScaleOnAxis(), closeTo(1, 0.001));
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'Every mobile destination and the visit dialog fit a narrow screen',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(360, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final router = AppRouter();
      addTearDown(router.dispose);

      await tester.pumpWidget(
        MaterialApp.router(routerConfig: router.config()),
      );
      await tester.pumpAndSettle();
      expect(
        find.text('The Divine Elegance of Modern Heritage Living'),
        findsOneWidget,
      );

      for (final (tab, heading) in [
        ('Plans', 'Architectural Layouts & Floor Plans'),
        ('Amenities', 'Spaces for Everyday Living'),
        ('Location', 'Effortlessly Connected'),
        ('Specs', 'Architectural Specifications & Material Quality'),
      ]) {
        await tester.tap(find.text(tab));
        await tester.pumpAndSettle();
        expect(find.text(heading), findsOneWidget);
        expect(tester.takeException(), isNull);
      }

      await tester.tap(find.text('Inquire'));
      await tester.pumpAndSettle();
      expect(find.text('+91 89805 05256'), findsWidgets);
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    },
  );
}
