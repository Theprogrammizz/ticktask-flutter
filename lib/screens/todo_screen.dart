import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktask_flutter/providers/database_provider.dart';
import 'package:ticktask_flutter/providers/user_provider.dart';
import 'package:ticktask_flutter/providers/todo_provider.dart';
import 'package:ticktask_flutter/screens/add_todo_screen.dart';
import 'package:ticktask_flutter/widgets/todo_tile.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final userAsync = ref.watch(userProvider);
    final todosAsync = ref.watch(todoProvider);

    return ColoredBox(
      color: theme.colorScheme.primary,
      child: SafeArea(
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
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const AddTodoScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Expanded(
                      child: todosAsync.when(
                        data: (todos) {
                          final pendingTodos =
                              todos.where((t) => !t.isDone).toList();

                          final completedTodos =
                              todos.where((t) => t.isDone).toList();
                          if (todos.isEmpty) {
                            return const Center(
                              child: Text("No tasks yet"),
                            );
                          }

                          return ListView(
                            padding: const EdgeInsets.only(bottom: 20),
                            children: [
                              /// PENDING TASKS
                              if (pendingTodos.isNotEmpty) ...[
                                const Text(
                                  "Pending",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: pendingTodos.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 10),
                                  itemBuilder: (context, index) {
                                    final todo = pendingTodos[index];

                                    return Dismissible(
                                      key: ValueKey(todo.id),
                                      background: Container(
                                        alignment: Alignment.centerLeft,
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: const Icon(Icons.check,
                                            color: Colors.white),
                                      ),
                                      secondaryBackground: Container(
                                        alignment: Alignment.centerRight,
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: const Icon(Icons.delete,
                                            color: Colors.white),
                                      ),
                                      confirmDismiss: (direction) async {
                                        if (direction ==
                                            DismissDirection.startToEnd) {
                                          /// COMPLETE TASK
                                          await ref
                                              .read(databaseProvider)
                                              .toggleTodo(todo);
                                          return false;
                                        }

                                        if (direction ==
                                            DismissDirection.endToStart) {
                                          /// DELETE TASK
                                          await ref
                                              .read(databaseProvider)
                                              .delTodo(todo.id);
                                          return true;
                                        }

                                        return false;
                                      },
                                      child: TodoTile(todo: todo),
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                              ],

                              /// COMPLETED TASKS
                              if (completedTodos.isNotEmpty) ...[
                                const Text(
                                  "Completed",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: completedTodos.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 10),
                                  itemBuilder: (context, index) {
                                    final todo = completedTodos[index];

                                    return Dismissible(
                                      key: ValueKey(todo.id),
                                      background: Container(
                                        alignment: Alignment.centerLeft,
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: const Icon(Icons.check,
                                            color: Colors.white),
                                      ),
                                      secondaryBackground: Container(
                                        alignment: Alignment.centerRight,
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: const Icon(Icons.delete,
                                            color: Colors.white),
                                      ),
                                      confirmDismiss: (direction) async {
                                        if (direction ==
                                            DismissDirection.startToEnd) {
                                          await ref
                                              .read(databaseProvider)
                                              .toggleTodo(todo);
                                          return false;
                                        }

                                        if (direction ==
                                            DismissDirection.endToStart) {
                                          await ref
                                              .read(databaseProvider)
                                              .delTodo(todo.id);
                                          return true;
                                        }

                                        return false;
                                      },
                                      child: TodoTile(todo: todo),
                                    );
                                  },
                                ),
                              ],
                            ],
                          );
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (err, _) => Center(
                          child: Text(err.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
