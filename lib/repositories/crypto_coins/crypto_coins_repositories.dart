import 'package:crypto/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:crypto/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:crypto/repositories/crypto_coins/models/crypto_coin_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class CryptoCoinsRepositories implements AbstractCoinsRepository {

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await Dio().get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,LTC,XRP,TON,BNB,DOGE,SOL,AID,DOV,CAG,NOT,&tsyms=USD,EUR');

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

  @override
  Future<CryptoCoinDetail> getCoinDetail(String currencyCode) async {
    print(currencyCode);
    final response = await Dio().get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode,&tsyms=USD,EUR');

    final data  = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final price = usdData['PRICE'];
    final imageUrl = usdData['IMAGEURL'];
    final toSymbol = usdData['TOSYMBOL'];
    final lastUpdate = usdData['LASTUPDATE'];
    final height24Hour = usdData['HIGH24HOUR'];
    final low24Hour = usdData['LOW24HOUR'];

    final value = CryptoCoinDetail(
      name: currencyCode,
      priceInUSD: price,
      imageUrl: 'https://www.cryptocompare.com/$imageUrl',
      toSymbol: toSymbol,
      lastUpdate: DateTime.fromMicrosecondsSinceEpoch(lastUpdate),
      height24Hour: height24Hour,
      low24Hour: low24Hour,
    );

    return value;
  }
}
