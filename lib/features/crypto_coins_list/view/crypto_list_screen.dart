import 'package:crypto/features/crypto_coins_list/widgets/cripto_coin_tile.dart';
import 'package:crypto/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../repositories/crypto_coins/crypto_coins_repositories.dart';
import '../../../repositories/crypto_coins/models/crypto_coin.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});

  final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {

  List<CryptoCoin>? _cryptoCoinsList;
  @override
  void initState() {
    _loadCryptoCoins();
    super.initState();
  }

  Future<void> _loadCryptoCoins() async {
    final coins = await GetIt.I<AbstractCoinsRepository>().getCoinsList();

    setState(() {
      _cryptoCoinsList = coins;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: (_cryptoCoinsList == null)
        ? const Center(
          child :CircularProgressIndicator()
        )
        : ListView.separated(
          padding: const EdgeInsets.only(top: 16) ,
          itemCount: _cryptoCoinsList!.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, i) {
            final coin = _cryptoCoinsList![i];
            return CryptoCoinTile(
              coin: coin,
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