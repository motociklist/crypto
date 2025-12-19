import 'dart:async';
import 'package:crypto_app/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:crypto_app/repositories/crypto_coins/models/crypto_coin_detail.dart';
import 'package:crypto_app/repositories/user_coins/user_coins_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'crypto_coin_event.dart';
part 'crypto_coin_state.dart';

class CryptoCoinBloc extends Bloc<CryptoCoinEvent, CryptoCoinState> {
  CryptoCoinBloc(this.coinsRepository, this.userCoinsRepository)
      : super(CryptoCoinInitial()) {
    on<LoadCryptoCoin>(_load);
    on<UpdateUserCoinAmount>(_updateAmount);
  }

  final AbstractCoinsRepository coinsRepository;
  final UserCoinsRepository userCoinsRepository;

  Future<void> _load(
    LoadCryptoCoin event,
    Emitter<CryptoCoinState> emit,
  ) async {
    try {
      if (state is! CryptoCoinLoaded) {
        emit(CryptoCoinLoading());
      }
      final cryptoCoin = await coinsRepository.getCoinDetail(event.currencyCode);
      final userAmount = await userCoinsRepository.getCoinAmount(event.currencyCode);
      
      emit(CryptoCoinLoaded(
        cryptoCoin: cryptoCoin,
        userAmount: userAmount,
      ));
    } catch (e, st) {
      emit(CryptoCoinLoadingFailure(exception: e));
      GetIt.I<Talker>().handle(e, st);
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _updateAmount(
    UpdateUserCoinAmount event,
    Emitter<CryptoCoinState> emit,
  ) async {
    try {
      if (state is CryptoCoinLoaded) {
        final curState = state as CryptoCoinLoaded;
        await userCoinsRepository.setCoinAmount(event.currencyCode, event.amount);
        emit(curState.copyWith(userAmount: event.amount));
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
