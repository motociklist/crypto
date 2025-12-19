part of 'crypto_coin_bloc.dart';

abstract class CryptoCoinState extends Equatable {}

class CryptoCoinInitial extends CryptoCoinState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinLoading extends CryptoCoinState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinLoaded extends CryptoCoinState {
  CryptoCoinLoaded({
    required this.cryptoCoin,
    this.userAmount = 0.0,
  });

  final CryptoCoinDetail cryptoCoin;
  final double userAmount;

  @override
  List<Object?> get props => [cryptoCoin, userAmount];

  CryptoCoinLoaded copyWith({
    CryptoCoinDetail? cryptoCoin,
    double? userAmount,
  }) {
    return CryptoCoinLoaded(
      cryptoCoin: cryptoCoin ?? this.cryptoCoin,
      userAmount: userAmount ?? this.userAmount,
    );
  }
}

class CryptoCoinLoadingFailure extends CryptoCoinState {
  CryptoCoinLoadingFailure({required this.exception});

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
