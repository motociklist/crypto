import 'package:crypto/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:crypto/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class CryptoCoinsRepositories implements AbstractCoinsRepository {

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await Dio().get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,LTC,XRP&tsyms=USD,EUR');

    final data  = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    debugPrint(response.toString());

    final cryptoCoinsList = dataRaw.entries
        .map((e) {
          final usdData =  (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
          final price = usdData['PRICE'];
          final imageURL = usdData['IMAGEURL'];
          return CryptoCoin(
             name: e.key,
             priceInUSD : price,
              imageUrl: 'https://www.cryptocompare.com/$imageURL'
          );
        })
        .toList();
    debugPrint(cryptoCoinsList.toString());

    return cryptoCoinsList;
  }
}
