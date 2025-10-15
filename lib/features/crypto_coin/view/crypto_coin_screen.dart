import 'package:flutter/material.dart';
import '../../../repositories/crypto_coins/crypto_coins_repositories.dart';
import '../../../repositories/crypto_coins/models/crypto_coin_detail.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinName;
  CryptoCoinDetail? _cryptoCoinDetail;
  bool _isLoading = true;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is String) {
        coinName = args;
        _loadCoinDetails();
      } else {
        debugPrint('❌ Не передано имя монеты в аргументах');
        setState(() => _isLoading = false);
      }
      _isInitialized = true;
    }
  }

  Future<void> _loadCoinDetails() async {
    if (coinName == null) return;

    try {
      final repo = CryptoCoinsRepositories();
      final coin = await repo.getCoinDetail(coinName!);

      if (!mounted) return;
      setState(() {
        _cryptoCoinDetail = coin;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Ошибка при загрузке данных: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_cryptoCoinDetail == null) {
      return const Scaffold(
        body: Center(child: Text('Не удалось загрузить данные')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(coinName ?? '...'),
        backgroundColor: const Color(0xFF918383),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.transparent,
                child: Image.network(
                  _cryptoCoinDetail!.imageUrl,
                  errorBuilder: (context, error, stack) =>
                  const Icon(Icons.error, color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF918383),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _cryptoCoinDetail!.name,
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
                          '${_cryptoCoinDetail!.height24Hour.toStringAsFixed(8)}\$',
                          style: const TextStyle(fontWeight: FontWeight.w600),
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
                          '${_cryptoCoinDetail!.low24Hour.toStringAsFixed(8)}\$',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
