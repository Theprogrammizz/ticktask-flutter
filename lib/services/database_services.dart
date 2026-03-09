import 'package:isar/isar.dart';
import 'package:ticktask_flutter/models/notes_model.dart';
import 'package:ticktask_flutter/models/todo_model.dart';
import 'package:ticktask_flutter/models/user_model.dart';

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

  Future<void> clearAllNotes() async {
    await db.writeTxn(() async {
      await db.notes.clear();
    });
  }

  Future<void> togglePinned(Notes note) async {
    note.pinned = !note.pinned;

    await db.writeTxn(() async {
      await db.notes.put(note);
    });
  }

  //! User Methods

  Future<void> saveUserInfo(String userName) async {
    final user = User()
      ..id = 0
      ..name = userName;

    await db.writeTxn(() async {
      await db.users.put(user);
    });
  }

  Future<User?> getUser() async {
    return await db.users.get(0);
  }

  Stream<User?> watchUser() {
    return db.users.watchObject(0, fireImmediately: true);
  }

  Future<void> toggleTheme() async {
    final user = await db.users.get(0);

    if (user == null) return;

    user.darkMode = !user.darkMode;

    await db.writeTxn(() async {
      await db.users.put(user);
    });
  }

  // ! Todo Methods

  Future<void> addTodo(Todos todo) async {
    await db.writeTxn(() async {
      await db.todos.put(todo);
    });
  }

  Future<void> toggleTodo(Todos todo) async {
    todo.isDone = !todo.isDone;

    await db.writeTxn(() async {
      await db.todos.put(todo);
    });
  }

  Future<void> delTodo(Id id) async {
    await db.writeTxn(() async {
      await db.todos.delete(id);
    });
  }

  Stream<List<Todos>> watchTodo() {
    return db.todos.where().sortByCreatedAt().watch(fireImmediately: true);
  }
}
