import 'package:flutter/material.dart';

class CriptoCoinScreen extends StatefulWidget {
  const CriptoCoinScreen({super.key});

  @override
  State<CriptoCoinScreen> createState() => _CriptoCoinScreenState();
}

class _CriptoCoinScreenState extends State<CriptoCoinScreen> {
  String? coinName;
  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is String, 'error444');
    coinName = args as String;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coinName ?? '...'),
      ),
    );
  }
}
