import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ticktask_flutter/providers/navigation_provider.dart';
import 'package:ticktask_flutter/screens/notes_screen.dart';
import 'package:ticktask_flutter/screens/setting_screen.dart';
import 'package:ticktask_flutter/screens/todo_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navProvider);

    final List<Widget> pages = [
      NotesScreen(),
      TodoScreen(),
      SettingScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GNav(
              padding: EdgeInsetsGeometry.all(16),
              gap: 8,
              backgroundColor: Theme.of(context).colorScheme.primary,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Theme.of(context).colorScheme.secondary,
              // tabBorder: Border.all(color: Colors.white, width: 1),
              tabActiveBorder: Border.all(color: Colors.white, width: 1),
              iconSize: 20,
              selectedIndex: currentIndex,
              onTabChange: (index) {
                ref.read(navProvider.notifier).updateIndex(index);
              },
              tabs: [
                GButton(
                  icon: Icons.notes,
                  text: "Notes",
                ),
                GButton(icon: Icons.check, text: "Todo"),
                GButton(icon: Icons.person, text: "Profile"),
              ]),
        ),
      ),
    );
  }
}
