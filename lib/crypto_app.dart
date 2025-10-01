import 'package:crypto/router/router.dart';
import 'package:crypto/theme/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto',
      theme: dartTheme,
      routes: routes,
    );
  }
}
