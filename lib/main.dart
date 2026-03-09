import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ticktask_flutter/core/app_theme.dart';
import 'package:ticktask_flutter/models/notes_model.dart';
import 'package:ticktask_flutter/models/todo_model.dart';
import 'package:ticktask_flutter/models/user_model.dart';
import 'package:ticktask_flutter/providers/isar_provider.dart';
import 'package:ticktask_flutter/providers/theme_provider.dart';
import 'package:ticktask_flutter/screens/startup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();

  final isarDb = await Isar.open([NotesSchema, UserSchema, TodosSchema],
      directory: dir.path);

  runApp(ProviderScope(
      overrides: [isarProvider.overrideWithValue(isarDb)], child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: StartupScreen(),
      // home: OnboardingScreen(),
    );
  }
}
