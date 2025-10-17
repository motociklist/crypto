import 'package:crypto_app/router/router.dart';
import 'package:crypto_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto',
      theme: dartTheme,
      routes: routes,
      navigatorObservers: [
        TalkerRouteObserver(
          GetIt.I<Talker>()
        ),
      ],
    );
  }
}
