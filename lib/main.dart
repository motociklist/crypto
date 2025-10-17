import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:crypto_app/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:crypto_app/repositories/crypto_coins/crypto_coins_repositories.dart';
import 'package:crypto_app/crypto_app.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('Tolker start');
  GetIt.I<Talker>().error('Tolker start');
  GetIt.I<Talker>().info('Tolker start');
  
  
  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
          () => CryptoCoinsRepositories());
  runApp(const MyApp());

}
