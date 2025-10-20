part of 'crypto_coin_bloc.dart';



abstract class CryptoCoinEvent extends Equatable {}

class LoadCryptoCoin extends CryptoCoinEvent {
  LoadCryptoCoin({required this.currencyCode, this.completer});

  final String currencyCode;
  final Completer? completer;

  @override
  List<Object?> get props => [currencyCode, completer];
}
