import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktask_flutter/models/todo_model.dart';
import 'package:ticktask_flutter/providers/database_provider.dart';

class AddTodoScreen extends ConsumerStatefulWidget {
  const AddTodoScreen({super.key});

  @override
  ConsumerState<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends ConsumerState<AddTodoScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Task"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              if (controller.text.isEmpty) return;

              final todo = Todos()
                ..title = controller.text
                ..createdAt = DateTime.now();

              await ref.read(databaseProvider).addTodo(todo);

              if (!context.mounted) return;

              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "What needs to be done?",
            border: InputBorder.none,
          ),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
