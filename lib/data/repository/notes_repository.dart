import 'package:isar_community/isar.dart';

import '../../core/model/NoteModel.dart';

class NoteRepository {
  final Isar db;

  NoteRepository(this.db);

  Future<int> createNote(NoteModel note) async {
    return await db.writeTxn(() async {
      return await db.noteModels.put(note);
    });
  }

  Future<List<NoteModel>> getAllNotes() async {
    return await db.noteModels
        .filter()
        .isArchivedEqualTo(false)
        .sortByUpdatedAtDesc()
        .findAll();
  }

  Future<NoteModel?> getNoteById(int id) async {
    return await db.noteModels.get(id);
  }

  Future<int> updateNote(NoteModel note) async {
    note.updatedAt = DateTime.now();

    return await db.writeTxn(() async {
      return await db.noteModels.put(note);
    });
  }

  Future<bool> deleteNote(int id) async {
    return await db.writeTxn(() async {
      return await db.noteModels.delete(id);
    });
  }

  Future<List<NoteModel>> getFavoriteNotes() async {
    return await db.noteModels
        .filter()
        .isFavoriteEqualTo(true)
        .isArchivedEqualTo(false)
        .sortByUpdatedAtDesc()
        .findAll();
  }

  Future<List<NoteModel>> getPinnedNotes() async {
    return await db.noteModels
        .filter()
        .isPinnedEqualTo(true)
        .isArchivedEqualTo(false)
        .sortByUpdatedAtDesc()
        .findAll();
  }

  Future<List<NoteModel>> searchNotes(String query) async {
    final searchQuery = query.trim();

    if (searchQuery.isEmpty) {
      return getAllNotes();
    }

    return await db.noteModels
        .filter()
        .isArchivedEqualTo(false)
        .group(
          (q) => q
              .titleContains(searchQuery, caseSensitive: false)
              .or()
              .contentContains(searchQuery, caseSensitive: false),
        )
        .sortByUpdatedAtDesc()
        .findAll();
  }

  Future<void> togglePin(NoteModel note) async {
    note.isPinned = !note.isPinned;
    await updateNote(note);
  }

  Future<void> deleteAllNotes() async {
    await db.writeTxn(() async {
      await db.noteModels.clear();
    });
  }
}
