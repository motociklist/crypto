part of 'crypto_coin_bloc.dart';



abstract class CryptoCoinEvent extends Equatable {}

class LoadCryptoCoin extends CryptoCoinEvent {
  LoadCryptoCoin({required this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}