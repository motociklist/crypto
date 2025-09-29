import 'package:crypto/features/crypto_coins_list/widgets/cripto_coin_tile.dart';
import 'package:flutter/material.dart';

class CriptoListScreen extends StatefulWidget {
  const CriptoListScreen({super.key, required this.title});

  final String title;

  @override
  State<CriptoListScreen> createState() => _CriptoListScreenState();
}

class _CriptoListScreenState extends State<CriptoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, i) {
          const coinName = 'Bitcoin';
          return const CryptoCoinTile(
            coinName: coinName,
          );
        },
      ),
    );
  }
}
