import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktask_flutter/providers/database_provider.dart';

final todoProvider = StreamProvider(
  (ref) {
    final db = ref.watch(databaseProvider);
    return db.watchTodo();
  },
);
