import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_app/features/about_me/bloc/about_me_bloc.dart';

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
  const _AboutMeView({super.key});

  @override
  Widget build(BuildContext context) {
    final aboutMeBloc = context.read<AboutMeBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль пользователя'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(radius: 50),
              const SizedBox(height: 16),
              const Text(
                'Иван Петров',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('ivan.petrov@example.com'),
              const SizedBox(height: 8),
              const Text('+7 (999) 123-45-67'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  aboutMeBloc.add(LoadMe(user: 'Иван Петров'));
                  aboutMeBloc.add(LoadMeEnd());
                  Navigator.pop(context);
                },
                child: const Text('Назад'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
