import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktask_flutter/providers/isar_provider.dart';
import 'package:ticktask_flutter/services/database_services.dart';

final databaseProvider = Provider(
  (ref) {
    final isar = ref.watch(isarProvider);
    return DatabaseServices(isar);
  },
);
