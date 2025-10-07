import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class CryptoCoinsRepositories {
  Future<void> getCoinsList() async {
    final response = await Dio().get('https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR');
    // print(response.toString());
    debugPrint('12');
    debugPrint(response.toString());
  }
}
