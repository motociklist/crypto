import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_coin_detail.g.dart';

@JsonSerializable()

class CryptoCoinDetail extends Equatable{
  const CryptoCoinDetail({
      required this.name,
      required this.priceInUSD,
      required this.imageUrl,
      required this.toSymbol,
      required this.lastUpdate,
      required this.height24Hour,
      required this.low24Hour,
  });

  final String name;
  final double priceInUSD;

  @JsonKey(name: 'IMAGEURL')
  final String imageUrl;

  @JsonKey(name: 'TOSYMBOL')
  final String toSymbol;

  @JsonKey(name: 'LASTUPDATE')
  final DateTime lastUpdate;

  @JsonKey(name: 'HIGH24HOUR')
  final double height24Hour;

  @JsonKey(name: 'LOW24HOUR')
  final double low24Hour;


  factory CryptoCoinDetail.fromJson(Map<String, dynamic> json) => _$CryptoCoinDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinDetailToJson(this);


  @override
  List<Object?> get props => [name, priceInUSD, imageUrl, toSymbol, lastUpdate, height24Hour, low24Hour];
}
