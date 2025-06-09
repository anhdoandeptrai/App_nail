import 'package:flutter/material.dart';
import 'package:app_nail/core/auth/getIt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'features/views/login_page.dart';
import 'core/themes/app_theme.dart';

Future<void> main() async {
  setupDI();
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Nail',
      theme: AppTheme.lightTheme,
      home: const LoginPage(),
    );
  }
}
