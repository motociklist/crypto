import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_app/features/crypto_coin/bloc/crypto_coin_bloc.dart';

class CryptoCoinScreen extends StatefulWidget {
  final String coinName;

  const CryptoCoinScreen({Key? key, required this.coinName}) : super(key: key);

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  late final CryptoCoinBloc _cryptoCoinBloc;
  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cryptoCoinBloc = context.read<CryptoCoinBloc>();
    _cryptoCoinBloc.add(
      LoadCryptoCoin(
        currencyCode: widget.coinName,
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            }
            if (state is CryptoCoinLoaded) {
              final coin = state.cryptoCoin;
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  const SizedBox(height: 40),
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.transparent,
                    child: Image.network(
                      coin.imageUrl,
                      errorBuilder: (context, error, stack) =>
                          const Icon(Icons.error, color: Colors.white, size: 80),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      coin.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _PortfolioCard(
                    amount: state.userAmount,
                    onEdit: () => _showEditAmountDialog(context, state.userAmount),
                  ),
                  const SizedBox(height: 24),
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
                        _DataRow(
                          title: 'High 24 Hour',
                          value: '${coin.high24Hour.toStringAsFixed(8)}\$',
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        _DataRow(
                          title: 'Low 24 Hour',
                          value: '${coin.low24Hour.toStringAsFixed(8)}\$',
                          crossAxisAlignment: CrossAxisAlignment.end,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            if (state is CryptoCoinLoadingFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Something went wrong'),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => _cryptoCoinBloc.add(
                        LoadCryptoCoin(currencyCode: widget.coinName),
                      ),
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  void _showEditAmountDialog(BuildContext context, double currentAmount) {
    _amountController.text = currentAmount.toString();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Amount'),
        content: TextField(
          controller: _amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(hintText: 'Enter amount'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(_amountController.text) ?? 0.0;
              _cryptoCoinBloc.add(
                UpdateUserCoinAmount(
                  currencyCode: widget.coinName,
                  amount: amount,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

class _PortfolioCard extends StatelessWidget {
  const _PortfolioCard({required this.amount, required this.onEdit});

  final double amount;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF00ADB5).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF00ADB5).withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'In your portfolio',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                amount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit, color: Color(0xFF00ADB5)),
          ),
        ],
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({
    required this.title,
    required this.value,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final String title;
  final String value;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.white60),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
