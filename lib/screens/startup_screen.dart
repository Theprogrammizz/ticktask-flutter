import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktask_flutter/providers/database_provider.dart';
import 'package:ticktask_flutter/screens/greet/onboarding_screen.dart';
import 'package:ticktask_flutter/screens/home_screen.dart';

class StartupScreen extends ConsumerWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseProvider);

    return FutureBuilder(
      future: db.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;

        if (user == null) {
          return OnboardingScreen();
        } else {
          return const HomeScreen();
        }
      },
    );
  }
}
