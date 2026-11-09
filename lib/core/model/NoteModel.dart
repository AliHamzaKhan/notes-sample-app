import 'package:isar_community/isar.dart';

part 'NoteModel.g.dart';

@collection
class NoteModel {
  Id id = Isar.autoIncrement;

  late String title;
  late String content;

  late DateTime createdAt;
  late DateTime updatedAt;

  bool isPinned = false;
  bool isFavorite = false;
  bool isArchived = false;

  int colorValue = 0xFFFFFFFF;
}