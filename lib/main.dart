import 'dart:async';
import 'package:crypto_app/firebase_options.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:crypto_app/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:crypto_app/repositories/crypto_coins/crypto_coins_repositories.dart';
import 'package:crypto_app/crypto_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';


void main() {
  runZonedGuarded(() async {
  WidgetsFlutterBinding.ensureInitialized();
    final talker = TalkerFlutter.init();
    GetIt.I.registerSingleton<Talker>(talker);
    GetIt.I<Talker>().debug('Talker started');


    final app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    talker.info(app.options.projectId);
    final dio = Dio();
    await Hive.initFlutter();


  dio.interceptors.add(
      TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printResponseData: false,
        ),
      ),
    );

    Bloc.observer = TalkerBlocObserver(
      talker: talker,
      settings: const TalkerBlocLoggerSettings(

      )
    );

    GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
          () => CryptoCoinsRepositories(dio: dio),
    );

    FlutterError.onError = (details) =>
        GetIt.I<Talker>().handle(details.exception, details.stack);

    runApp(const MyApp());
  }, (error, stackTrace) {
    GetIt.I<Talker>().handle(error, stackTrace);
  });
}
