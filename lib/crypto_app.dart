import 'package:crypto_app/features/crypto_coin/bloc/crypto_coin_bloc.dart';
import 'package:crypto_app/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:crypto_app/repositories/user_coins/user_coins_repository.dart';
import 'package:crypto_app/router/router.dart';
import 'package:crypto_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CryptoCoinBloc(
            GetIt.I<AbstractCoinsRepository>(),
            GetIt.I<UserCoinsRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'CryptoCurrenciesList',
        theme: darkTheme,
        routes: routes,
      ),
    );
  }
}
