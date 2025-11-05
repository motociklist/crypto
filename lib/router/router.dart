import 'package:crypto_app/features/about_me/view/about_me_screen.dart';
import 'package:crypto_app/features/login/view/login_screen.dart';
import 'package:crypto_app/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:crypto_app/features/crypto_coin/view/crypto_coin_screen.dart';
import 'package:crypto_app/features/crypto_coins_list/view/crypto_list_screen.dart';
import 'package:crypto_app/features/crypto_coin/bloc/crypto_coin_bloc.dart';


final routes = {
  '/': (context) => const AuthPage(),
  '/coins': (context) => const CryptoListScreen(title: 'Crypto'),
  '/coin': (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      return BlocProvider(
        create: (_) => CryptoCoinBloc(GetIt.I<AbstractCoinsRepository>()),
        child: CryptoCoinScreen(coinName: args),
      );
    } else {
      return const Scaffold(
        body: Center(child: Text('Ошибка: не передан coinName')),
      );
    }
  },
  '/about_me': (context) => const AboutMeScreen(),
};

