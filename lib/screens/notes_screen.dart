import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktask_flutter/providers/database_provider.dart';
import 'package:ticktask_flutter/providers/notes_provider.dart';
import 'package:ticktask_flutter/providers/search_provider.dart';
import 'package:ticktask_flutter/screens/add_notes_screen.dart';
import 'package:ticktask_flutter/widgets/note_tile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final notesAsync = ref.watch(notesProvider);
    final query = ref.watch(searchQueryProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: notesAsync.when(
          data: (notes) {
            final filteredNotes = notes.where((note) {
              final title = note.title.toLowerCase();
              final body = note.body?.toLowerCase() ?? "";

              return title.contains(query) || body.contains(query);
            }).toList();

            return ColoredBox(
              color: theme.colorScheme.primary,
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hey, John!",
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: theme.colorScheme.surface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),

                        Text(
                          "How is your day going?",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.surface
                                .withValues(alpha: 0.9),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Search Field
                        TextField(
                          onChanged: (value) {
                            ref
                                .read(searchQueryProvider.notifier)
                                .searchQuery(value);
                          },
                          decoration: InputDecoration(
                            hintText: "Search Notes",
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: const Color(0xFFF2F2F2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
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
                                "Notes",
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
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => AddNoteScreen(),
                                    ));
                                  },
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Notes Grid
                          Expanded(
                            child: filteredNotes.isEmpty
                                ? const Center(child: Text("No notes found"))
                                : MasonryGridView.builder(
                                    itemCount: filteredNotes.length,
                                    gridDelegate:
                                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),
                                    mainAxisSpacing: 14,
                                    crossAxisSpacing: 14,
                                    itemBuilder: (context, index) {
                                      final note = filteredNotes[index];

                                      return Dismissible(
                                        key: ValueKey(note.id),
                                        direction: DismissDirection.endToStart,
                                        background: Container(
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
                                        onDismissed: (_) {
                                          ref
                                              .read(databaseProvider)
                                              .delNote(note.id);
                                        },
                                        child: NoteTile(
                                          note: note,
                                        ),
                                      );
                                    },
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          error: (err, _) => Center(child: Text(err.toString())),
          loading: () => Center(child: CircularProgressIndicator())),
    );
  }
}
