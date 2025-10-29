import 'package:crypto_app/router/router.dart';
import 'package:crypto_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Crypto',
      theme: dartTheme,
      routerConfig: _appRouter.config(
          navigatorObservers: () => [
            TalkerRouteObserver(GetIt.I<Talker>()),
          ],
      ),
      //routes: routes,
      // navigatorObservers: [
      //   TalkerRouteObserver(
      //     GetIt.I<Talker>()
      //   ),
      // ],
    );
  }
}
