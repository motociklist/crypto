import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_coin_detail.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class CryptoCoinDetail extends Equatable {
  const CryptoCoinDetail({
    required this.name,
    required this.priceInUSD,
    required this.imageUrl,
    required this.toSymbol,
    required this.lastUpdate,
    required this.high24Hour,
    required this.low24Hour,
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final double priceInUSD;

  @HiveField(2)
  @JsonKey(name: 'TOSYMBOL')
  final String toSymbol;

  @HiveField(3)
  @JsonKey(name: 'IMAGEURL')
  final String imageUrl;

  @HiveField(4)
  @JsonKey(name: 'LASTUPDATE')
  final DateTime lastUpdate;

  @HiveField(5)
  @JsonKey(name: 'HIGH24HOUR')
  final double high24Hour;

  @HiveField(6)
  @JsonKey(name: 'LOW24HOUR')
  final double low24Hour;

  factory CryptoCoinDetail.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinDetailToJson(this);

  @override
  List<Object?> get props => [
        name,
        priceInUSD,
        imageUrl,
        toSymbol,
        lastUpdate,
        high24Hour,
        low24Hour,
      ];
}
