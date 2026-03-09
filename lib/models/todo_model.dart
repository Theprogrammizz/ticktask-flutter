import 'package:isar/isar.dart';

part 'todo_model.g.dart';

@collection
class Todos {
  Id id = Isar.autoIncrement;

  late String title;

  bool isDone = false;

  String? time;

  late DateTime createdAt;
}
