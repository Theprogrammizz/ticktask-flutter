import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ticktask_flutter/providers/navigation_provider.dart';
import 'package:ticktask_flutter/screens/notes_screen.dart';
import 'package:ticktask_flutter/screens/profile_screen.dart';
import 'package:ticktask_flutter/screens/todo_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navProvider);

    final List<Widget> pages = [
      NotesScreen(key: ValueKey(0)),
      TodoScreen(key: ValueKey(1)),
      ProfileScreen(key: ValueKey(2)),
    ];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: pages[currentIndex],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: GNav(
                padding: EdgeInsetsGeometry.all(16),
                backgroundColor: Theme.of(context).colorScheme.primary,
                color: Theme.of(context).colorScheme.surface,
                activeColor: Theme.of(context).colorScheme.primary,
                tabBackgroundColor: Theme.of(context).colorScheme.surface,
                iconSize: 20,
                selectedIndex: currentIndex,
                onTabChange: (index) {
                  ref.read(navProvider.notifier).updateIndex(index);
                },
                tabBorderRadius: 12,
                tabs: [
                  GButton(
                    icon: Icons.notes,
                    padding: EdgeInsets.all(10),
                  ),
                  GButton(
                    icon: Icons.check,
                    padding: EdgeInsets.all(10),
                  ),
                  GButton(
                    icon: Icons.person,
                    padding: EdgeInsets.all(10),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
