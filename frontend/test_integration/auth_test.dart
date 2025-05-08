import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/presentation/views/auth/auth_login_success_view.dart';
import 'package:frontend/presentation/widgets/other/email_textfield.dart';
import 'package:frontend/presentation/widgets/other/flow_button.dart';
import 'package:frontend/presentation/widgets/other/password_textfield.dart';
import 'package:integration_test/integration_test.dart';
import 'package:frontend/main.dart' as app;

void main() {
  group("Integration test", () {
    //Initialize the integration test
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets("Login test", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 1));

      final continueButton = find.byKey(const Key("onboarding_next_button"));

      //Tap button 2 times to skip the onboarding
      await tester.tap(continueButton);
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await tester.tap(continueButton);
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 1));

      final loginButton = find.byKey(const Key("login_button"));

      //Login
      await tester.tap(loginButton);
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 1));

      final emailButton = find.byKey(const Key("email_button"));

      //Tap the email button
      await tester.tap(emailButton);
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 1));

      final emailField = find.byType(EmailTextField);

      final passwordField = find.byType(PasswordTextField);

      //Fill out credentials
      await tester.enterText(emailField, "admin@ex.com");
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.enterText(passwordField, "admin");
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 1));

      //Tap the login button

      final loginButton2 = find.byType(FlowButton);
      await tester.tap(loginButton2);
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 1));

      //Check if the Success view is shown
      expect(find.byType(AuthLoginSuccessView), findsOneWidget);
    });
  });
}
