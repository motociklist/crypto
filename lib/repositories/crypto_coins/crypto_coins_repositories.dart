import 'package:crypto_app/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:crypto_app/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:crypto_app/repositories/crypto_coins/models/crypto_coin_detail.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoCoinsRepositories implements AbstractCoinsRepository {
  final Dio dio;
  final Box<dynamic> cryptoCoinsBox;

  CryptoCoinsRepositories({
    required this.dio,
    required this.cryptoCoinsBox
  });

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    var cryptoCoinsList = [];
    try{
      cryptoCoinsList = await _fetchCoinsListFromApi();
      final cryptoCoinsMap = {
        for (var e in cryptoCoinsList) e.name: e
      };
      await cryptoCoinsBox.putAll(cryptoCoinsMap);
    } catch (e, st) {
      GetIt.instance<Talker>().handle(e, st);
      cryptoCoinsList =  cryptoCoinsBox.values.cast<CryptoCoin>().toList();
    }

    cryptoCoinsList.sort((a,b) => b.priceInUSD.compareTo(a.priceInUSD));

    print(12);
    print(cryptoCoinsList.toString());
    print(cryptoCoinsList.map((e) => '${e.name} ${e.priceInUSD}').join(', '));

    return cryptoCoinsList.cast<CryptoCoin>();
  }

  Future<List<CryptoCoin>> _fetchCoinsListFromApi() async {
    final response = await dio.get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,LTC,XRP,TON,BNB,DOGE,SOL,AID,DOV,CAG,NOT,&tsyms=USD,EUR');
    final data  = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    //debugPrint(response.toString());
    
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
    //debugPrint(cryptoCoinsList.toString());

    final cryptoCoinsMap = {
      for (var e in cryptoCoinsList) e.name: e
    };
    await cryptoCoinsBox.putAll(cryptoCoinsMap);

    return cryptoCoinsList;
  }

  @override
  Future<CryptoCoinDetail> getCoinDetail(String currencyCode) async {
    try {
      final coin = await _fetchCoinDetailsFromApi(currencyCode);
      cryptoCoinsBox.put(currencyCode, coin);
      return coin;
    } catch (e, st) {
      GetIt.instance<Talker>().handle(e, st);
      print(cryptoCoinsBox.containsKey(currencyCode));
      //FIXME
      print(cryptoCoinsBox.get(currencyCode));
      if (cryptoCoinsBox.containsKey(currencyCode)) {
        return cryptoCoinsBox.get(currencyCode) as CryptoCoinDetail;
      } else {
        throw Exception('Не удалось получить данные о валюте: $currencyCode');
      }
    }
  }

  Future<CryptoCoinDetail> _fetchCoinDetailsFromApi(String currencyCode) async {
    final response = await dio.get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode,&tsyms=USD,EUR');
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
