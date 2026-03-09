import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktask_flutter/providers/user_provider.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final userAsync = ref.watch(userProvider);

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ColoredBox(
          color: theme.colorScheme.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userAsync.when(
                      data: (user) {
                        final name = user?.name ?? "User";

                        return Text(
                          "Stay productive, $name!",
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: theme.colorScheme.surface,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                      loading: () => const SizedBox(),
                      error: (_, __) => const SizedBox(),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Let's get things done today.",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.surface.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Content Sheet
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Notes Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Todos",
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // Add button
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: theme.colorScheme.primary,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.add, size: 20),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Notes Grid
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
