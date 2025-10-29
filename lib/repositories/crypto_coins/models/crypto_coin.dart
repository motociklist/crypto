import 'package:hive_flutter/adapters.dart';

part 'crypto_coin.g.dart';

@HiveType(typeId: 2)
class CryptoCoin {
  CryptoCoin({
    required this.name,
    required this.priceInUSD,
    required this.imageUrl,
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final double priceInUSD;

  @HiveField(2)
  final String imageUrl;
}