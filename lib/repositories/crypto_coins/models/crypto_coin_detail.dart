import 'package:equatable/equatable.dart';

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
  final String imageUrl;
  final String toSymbol;
  final DateTime lastUpdate;
  final double height24Hour;
  final double low24Hour;


  @override
  List<Object?> get props => [name, priceInUSD, imageUrl, toSymbol, lastUpdate, height24Hour, low24Hour];
}
