import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../model/NoteModel.dart';

class DatabaseService {
  late Isar _db;

  Isar get db => _db;

  bool get isInitialized => Isar.instanceNames.isNotEmpty;

  Future<void> init() async {
    if (Isar.instanceNames.contains('notes_db')) {
      _db = Isar.getInstance('notes_db')!;
      return;
    }

    final directory = await getApplicationDocumentsDirectory();

    _db = await Isar.open(
      [NoteModelSchema],
      directory: directory.path,
      name: 'notes_db',
    );
  }

  Future<void> close() async {
    if (Isar.instanceNames.contains('notes_db')) {
      await _db.close();
    }
  }
}