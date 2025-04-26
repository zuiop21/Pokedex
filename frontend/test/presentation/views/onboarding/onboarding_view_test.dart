import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/presentation/views/onboarding/onboarding_view.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  setUpAll(() {
    registerFallbackValue(MaterialPageRoute(builder: (_) => const SizedBox()));
  });
  testWidgets(
      'Given page index is 0 when button is clicked twice then we should navigate to new page',
      (tester) async {
    final navigatorObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        home: const OnboardingView(),
        navigatorObservers: [navigatorObserver],
        onGenerateRoute: (settings) {
          if (settings.name == '/auth/onboarding/option') {
            return MaterialPageRoute(
              builder: (_) => const Text('Dummy Screen'),
            );
          }
          return null;
        },
      ),
    );

    expect(find.text('All Pokémons in one place'), findsOneWidget);
    expect(
      find.text(
          'Access a vast list of Pokémons from every generation ever made by Nintendo'),
      findsOneWidget,
    );
    expect(find.byType(Image), findsOneWidget);

    final buttonFinder = find.byKey(const Key('onboarding_next_button'));

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();

    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(find.text('Keep your Pokédex up to date'), findsOneWidget);
    expect(
      find.text(
          'Register and keep your profile, favourite Pokémons, settings and much more!'),
      findsOneWidget,
    );

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    // Verify that Navigator.pushNamed was called with correct route
    verify(() => navigatorObserver.didPush(any(), any())).called(2);
  });
}
