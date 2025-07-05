import 'package:flutter/material.dart';
import 'screens/admin_login_page_new.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  debugPrint('=== Starting ReGen Admin Panel ===');
  debugPrint('✓ Running in standalone mode (no backend connection)');
  debugPrint('=== Launching App ===');

  runApp(
    const MaterialApp(
      title: 'ReGen Admin Panel',
      debugShowCheckedModeBanner: false,
      home: AdminLoginScreen(),
    ),
  );
}
