import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ticktask_flutter/models/todo_model.dart';
import 'package:ticktask_flutter/providers/database_provider.dart';

class TodoTile extends ConsumerWidget {
  final Todos todo;

  const TodoTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formattedTime = DateFormat('hh:mm a').format(todo.createdAt);
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          /// PRIORITY STRIPE
          Container(
            width: 4,
            height: 42,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(3),
            ),
          ),

          const SizedBox(width: 14),

          /// TASK CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formattedTime,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  todo.title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                    color:
                        todo.isDone ? Colors.grey : theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),

          /// COMPLETE BUTTON
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              ref.read(databaseProvider).toggleTodo(todo);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: todo.isDone ? Colors.green : Colors.grey.shade400,
                  width: 2,
                ),
                color: todo.isDone ? Colors.green : Colors.transparent,
              ),
              child: todo.isDone
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
