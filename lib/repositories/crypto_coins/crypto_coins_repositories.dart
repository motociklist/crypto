import 'package:crypto/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class CryptoCoinsRepositories {
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await Dio().get('https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR');
    final data  = response.data as Map<String, dynamic>;
    debugPrint(response.toString());
    final cryptoCoinsList = data.entries
        .map((e) => CryptoCoin(
            name: e.key,
            priceInUSD: (e.value as Map<String, dynamic>)['USD'],
          ))
        .toList();
    return cryptoCoinsList;
  }
}
