import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/presentation/views/onboarding/onboarding_auth_option_view.dart';
import 'package:mocktail/mocktail.dart';

import 'onboarding_view_test.dart';

class FakeRoute extends Fake implements Route<dynamic> {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeRoute());
  });
  group('Button actions', () {
    testWidgets(
        'given onboarding auth option view when create account button is clicked then navigate to new page',
        (tester) async {
      final navigatorObserver = MockNavigatorObserver();
      //Setup
      await tester.pumpWidget(
        MaterialApp(
          home: const OnboardingAuthOptionView(),
          navigatorObservers: [navigatorObserver],
          onGenerateRoute: (settings) {
            if (settings.name == "/auth/onboarding/new") {
              return MaterialPageRoute(
                builder: (_) => const Text('Dummy Sign Up Screen'),
              );
            }
            return null;
          },
        ),
      );

      //Check widget appearance
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('Are you ready for this adventure?'), findsOneWidget);
      expect(
          find.text(
              'Simply create an account and start exploring the world of Pokémons today!'),
          findsOneWidget);
      final createButton = find.byKey(const Key("create_account_button"));
      expect(createButton, findsOneWidget);

      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();

      //Check button action
      await tester.tap(createButton);
      await tester.pumpAndSettle();

      verify(() => navigatorObserver.didPush(any(), any())).called(2);
      expect(find.text('Dummy Sign Up Screen'), findsOneWidget);
    });

    testWidgets(
        'given onboarding auth option view when login button is clicked then navigate to new page',
        (tester) async {
      final navigatorObserver = MockNavigatorObserver();
      //Setup
      await tester.pumpWidget(
        MaterialApp(
          home: const OnboardingAuthOptionView(),
          navigatorObservers: [navigatorObserver],
          onGenerateRoute: (settings) {
            if (settings.name == "/auth/onboarding/login") {
              return MaterialPageRoute(
                builder: (_) => const Text('Dummy Login Screen'),
              );
            }
            return null;
          },
        ),
      );

      //Check widget appearance
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('Are you ready for this adventure?'), findsOneWidget);
      expect(
          find.text(
              'Simply create an account and start exploring the world of Pokémons today!'),
          findsOneWidget);
      final createButton = find.byKey(const Key("login_button"));
      expect(createButton, findsOneWidget);

      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();

      //Check button action
      await tester.tap(createButton);
      await tester.pumpAndSettle();

      verify(() => navigatorObserver.didPush(any(), any())).called(2);
      expect(find.text('Dummy Login Screen'), findsOneWidget);
    });
  });
}
