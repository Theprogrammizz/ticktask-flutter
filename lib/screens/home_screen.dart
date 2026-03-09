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
            padding: const EdgeInsets.all(10.0),
            child: GNav(
                padding: EdgeInsetsGeometry.all(13),
                gap: 8,
                backgroundColor: Theme.of(context).colorScheme.primary,
                color: Colors.white,
                activeColor: Colors.white,
                tabBorder: Border.all(color: Colors.white, width: 1),
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
                  GButton(icon: Icons.check, text: "Todos"),
                  GButton(icon: Icons.person, text: "Profile"),
                ]),
          ),
        ),
      ),
    );
  }
}
