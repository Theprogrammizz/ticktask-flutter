import 'package:isar/isar.dart';

part 'notes_model.g.dart';

@collection
class Notes {
  Id id = Isar.autoIncrement;

  @Index(caseSensitive: false)
  late String title;

  late String? body;

  int colorValue = 0xFFFFFFFF;

  @Index()
  DateTime createdAt = DateTime.now();

  bool pinned = false;
}
