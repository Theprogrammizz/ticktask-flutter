import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktask_flutter/models/notes_model.dart';
import 'package:ticktask_flutter/providers/database_provider.dart';

final notesProvider = StreamProvider<List<Notes>>(
  (ref) {
    final db = ref.watch(databaseProvider);
    return db.watchNotes();
  },
);
