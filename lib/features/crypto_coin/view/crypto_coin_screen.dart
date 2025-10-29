import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_app/features/crypto_coin/bloc/crypto_coin_bloc.dart';
import 'package:crypto_app/repositories/crypto_coins/models/crypto_coin_detail.dart';


@RoutePage()

class CryptoCoinScreen extends StatefulWidget {
  final String coinName;

  const CryptoCoinScreen({Key? key, required this.coinName}) : super(key: key);

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  late final CryptoCoinBloc _cryptoCoinBloc;

  @override
  void initState() {
    super.initState();
    _cryptoCoinBloc = context.read<CryptoCoinBloc>();
    _cryptoCoinBloc.add(
      LoadCryptoCoin(
        completer: null,
        currencyCode: widget.coinName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coinName),
        backgroundColor: const Color(0xFF918383),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer<void>();
          _cryptoCoinBloc.add(
            LoadCryptoCoin(
              completer: completer,
              currencyCode: widget.coinName,
            ),
          );
          return completer.future;
        },
        child: BlocBuilder<CryptoCoinBloc, CryptoCoinState>(
          builder: (context, state) {
            if (state is CryptoCoinLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CryptoCoinLoaded) {
              final CryptoCoinDetail coin = state.coinCoin;
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.transparent,
                        child: Image.network(
                          coin.imageUrl,
                          errorBuilder: (context, error, stack) =>
                          const Icon(Icons.error, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 18.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF918383),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          coin.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF151515),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'High 24 Hour',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white60,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${coin.height24Hour.toStringAsFixed(8)}\$',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'Low 24 Hour',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white60,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${coin.low24Hour.toStringAsFixed(8)}\$',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is CryptoCoinLoadingFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Something went wrong',
                      style: theme.textTheme.headlineMedium,
                    ),
                    Text(
                      'Please try again later',
                      style: theme.textTheme.labelSmall?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () {
                        _cryptoCoinBloc.add(
                          LoadCryptoCoin(
                            completer: null,
                            currencyCode: widget.coinName,
                          ),
                        );
                      },
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              );
            }
            // По умолчанию - показываем индикатор загрузки
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
