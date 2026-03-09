import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktask_flutter/models/user_model.dart';
import 'package:ticktask_flutter/providers/database_provider.dart';

final userProvider = StreamProvider<User?>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchUser();
});
