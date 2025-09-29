import 'package:crypto/features/crypto_coin/view/crypto_coin_screen.dart';
import 'package:crypto/features/crypto_coins_list/view/crypto_list_screen.dart';

final routes = {
  '/': (context) => const CriptoListScreen(title: 'Cripto'),
  '/coin': (context) => const CriptoCoinScreen(),
};
