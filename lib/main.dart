import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:crypto/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:crypto/repositories/crypto_coins/crypto_coins_repositories.dart';
import 'package:crypto/crypto_app.dart';

void main() {
  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
          () => CryptoCoinsRepositories());
  runApp(const MyApp());
}
