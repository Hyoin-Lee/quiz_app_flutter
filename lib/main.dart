import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/navigation_page.dart';
import 'package:quiz_app_flutter/pages/login_or_register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'PLUMS',
      debugShowCheckedModeBanner: false,
      home: NavigationPage(),
    );
  }
}
