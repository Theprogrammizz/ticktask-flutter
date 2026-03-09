import 'package:isar/isar.dart';
import 'package:ticktask_flutter/models/notes_model.dart';

class DatabaseServices {
  final Isar db;

  DatabaseServices(this.db);

  Future<void> addNote(Notes note) async {
    await db.writeTxn(() async {
      await db.notes.put(note);
    });
  }

  Future<void> delNote(Id id) async {
    await db.writeTxn(() async {
      await db.notes.delete(id);
    });
  }

  Future<void> updateNote(Notes note) async {
    await db.writeTxn(() async {
      await db.notes.put(note);
    });
  }

  Stream<List<Notes>> watchNotes() {
    return db.notes.where().watch(fireImmediately: true);
  }
}
