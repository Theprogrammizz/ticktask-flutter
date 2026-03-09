import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktask_flutter/providers/user_provider.dart';

final themeModeProvider = Provider<ThemeMode>((ref) {
  final userAsync = ref.watch(userProvider);

  return userAsync.maybeWhen(
    data: (user) {
      if (user?.darkMode == true) {
        return ThemeMode.dark;
      }

      return ThemeMode.light;
    },
    orElse: () => ThemeMode.light,
  );
});
