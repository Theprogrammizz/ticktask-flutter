import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktask_flutter/providers/database_provider.dart';
import 'package:ticktask_flutter/providers/user_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userAsync = ref.watch(userProvider);

    return userAsync.when(
      data: (user) {
        nameController.text = user?.name ?? "";

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profile",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Your Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      final name = nameController.text;

                      if (name.isEmpty) return;

                      await ref.read(databaseProvider).saveUserInfo(name);

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Name updated"),
                        ),
                      );
                    },
                    child: const Text("Save"),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Divider(
                  color: Theme.of(context).colorScheme.onSurface,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(Icons.delete_outline, color: Colors.red),
                  title: const Text("Clear All Notes"),
                  onTap: () {
                    // show dialog
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Delete all notes?"),
                        content: const Text("This action cannot be undone."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async {
                              await ref.read(databaseProvider).clearAllNotes();

                              if (!context.mounted) return;

                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("All notes deleted"),
                                ),
                              );
                            },
                            child: const Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Divider(
                  color: Theme.of(context).colorScheme.onSurface,
                  thickness: 1,
                ),
                SwitchListTile(
                  title: const Text("Dark Mode"),
                  value: user?.darkMode ?? false,
                  onChanged: (_) {
                    ref.read(databaseProvider).toggleTheme();
                  },
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Text(e.toString()),
      ),
    );
  }
}
