import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_app/features/about_me/bloc/about_me_bloc.dart';
import 'package:intl/intl.dart';

class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AboutMeBloc(),
      child: const _AboutMeView(),
    );
  }
}

class _AboutMeView extends StatelessWidget {
  const _AboutMeView();

  @override
  Widget build(BuildContext context) {
    final aboutMeBloc = context.read<AboutMeBloc>();
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль пользователя'),
        centerTitle: true,
      ),
      body: user == null
          ? const Center(
        child: Text(
          "Пользователь не найден",
          style: TextStyle(fontSize: 18),
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50),
            const SizedBox(height: 16),
            const Text("Информация об аккаунте"),
            const SizedBox(height: 6),

            const UserInfoCard(),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                aboutMeBloc.add(LoadMe(user: user.email ?? ''));
                aboutMeBloc.add(LoadMeEnd());
                Navigator.pop(context);
              },
              child: const Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({super.key});

  String formatDate(DateTime? date) {
    if (date == null) return "—";

    return DateFormat('dd MMMM yyyy, HH:mm').format(date);
  }


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _row("Email", user.email ?? "—"),
          _row("Email подтверждён", user.emailVerified ? "Да" : "Нет"),
          _row("Имя", user.displayName ?? "—"),
          _row("Телефон", user.phoneNumber ?? "—"),
          _row("Создан", formatDate(user.metadata.creationTime)),
          _row("Последний вход", formatDate(user.metadata.lastSignInTime)),
        ],
      ),
    );
  }

  Widget _row(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$key: ",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
