import 'dart:async';
import 'package:crypto_app/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:crypto_app/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:crypto_app/repositories/crypto_coins/models/crypto_coin_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'crypto_coin_event.dart';
part 'crypto_coin_state.dart';



class CryptoCoinBloc extends Bloc<CryptoCoinEvent, CryptoCoinState> {
  final AbstractCoinsRepository coinsRepository;

  CryptoCoinBloc(this.coinsRepository) : super (CryptoCoinInitial()) {

    // on<LoadCryptoList>((event,emit) async {
    //   try {
    //     if (state is! CryptoListLoaded) {
    //       emit(CryptoListLoading());
    //     }
    //     final coinsList = await coinsRepository.getCoinsList();
    //     emit(CryptoListLoaded(coinsList: coinsList));
    //   }
    //   catch (e, st) {
    //     emit(CryptoListLoadingFailure(exception: e));
    //     GetIt.I<Talker>().handle(e,st);
    //   }
    //   finally {
    //     event.completer?.complete();
    //   }
    // });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}