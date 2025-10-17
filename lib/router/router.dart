import 'package:crypto_app/features/crypto_coin/view/crypto_coin_screen.dart';
import 'package:crypto_app/features/crypto_coins_list/view/crypto_list_screen.dart';

final routes = {
  '/': (context) => const CryptoListScreen(title: 'Crypto'),
  '/coin': (context) => const CryptoCoinScreen(),
};
