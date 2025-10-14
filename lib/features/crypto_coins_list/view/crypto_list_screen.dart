import 'package:crypto/features/crypto_coins_list/bloc/crypto_list_bloc.dart';
import 'package:crypto/features/crypto_coins_list/widgets/crypto_coin_tile.dart';
import 'package:crypto/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});

  final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {

  final _cryptoListBloc = CryptoListBloc(
    GetIt.I<AbstractCoinsRepository>(),
  );

  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: BlocBuilder<CryptoListBloc, CryptoListState>(
        bloc: _cryptoListBloc,
        builder: (context, state) {
          if (state is CryptoListLoaded) {
            return ListView.separated(
                padding: const EdgeInsets.only(top: 16) ,
                itemCount: state.coinsList.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, i) {
                  final coin = state.coinsList[i];
                  return CryptoCoinTile(
                    coin: coin,
                  );
                },
              );
          }
          if (state is CryptoListLoadingFailure){
            return Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Something went wrong',
                    style: theme.textTheme.headlineMedium,
                  ),
                  Text(
                    'Please try again later',
                    style: theme.textTheme.labelSmall?.copyWith(fontSize: 16),
                  ),
                ],
              )
            );
          }
          return const Center(
              child :CircularProgressIndicator()
            );
        },
      ),

      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.download),
      //   onPressed: () async {
      //    await _loadCryptoCoins()
      //   },
      // ),
    );
  }
}