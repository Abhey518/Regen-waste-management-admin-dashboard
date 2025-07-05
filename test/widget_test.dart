// This is a basic Flutter widget test for ReGen Admin Panel.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:web_admin/screens/admin_login_page_new.dart';

void main() {
  testWidgets('ReGen Admin Login Screen displays correctly', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AdminLoginScreen(),
      ),
    );

    // Verify that the ReGen Admin title is displayed.
    expect(find.text('ReGen Admin'), findsOneWidget);

    // Verify that admin ID and password fields are present.
    expect(find.text('Admin ID'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Verify that the LOGIN button is present.
    expect(find.text('LOGIN'), findsOneWidget);
  });

  testWidgets('Login form fields accept input', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AdminLoginScreen(),
      ),
    );

    // Find the admin ID and password text fields.
    final adminIdField = find.byType(TextField).first;
    final passwordField = find.byType(TextField).last;

    // Enter text in the admin ID field.
    await tester.enterText(adminIdField, 'RA0000S');
    expect(find.text('RA0000S'), findsOneWidget);

    // Enter text in the password field.
    await tester.enterText(passwordField, 'password123');
    expect(find.text('password123'), findsOneWidget);
  });
}
