
import 'package:get/get.dart';

import '../../../core/model/NoteModel.dart';
import '../../../data/repository/notes_repository.dart';

class HomeController extends GetxController {
  final NoteRepository repository;

  HomeController(this.repository);

  final notes = <NoteModel>[].obs;
  final searchedNotes = <NoteModel>[].obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  Future<void> loadNotes() async {
    try {
      isLoading.value = true;

      final result = await repository.getAllNotes();

      result.sort((a, b) {
        if (a.isPinned != b.isPinned) {
          return a.isPinned ? -1 : 1;
        }
        return b.updatedAt.compareTo(a.updatedAt);
      });

      notes.assignAll(result);
      searchedNotes.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Unable to load notes: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createNote({
    required String title,
    required String content,
  }) async {
    final now = DateTime.now();

    final note = NoteModel()
      ..title = title
      ..content = content
      ..createdAt = now
      ..updatedAt = now;

    await repository.createNote(note);
    await loadNotes();
  }

  Future<void> updateNote(NoteModel note) async {
    await repository.updateNote(note);
    await loadNotes();
  }

  Future<void> deleteNote(int id) async {
    await repository.deleteNote(id);
    await loadNotes();

    Get.snackbar('Deleted', 'Note deleted successfully');
  }

  Future<void> togglePin(NoteModel note) async {
    await repository.togglePin(note);
    await loadNotes();
  }

  Future<void> searchNotes(String query) async {
    searchQuery.value = query;

    if (query.trim().isEmpty) {
      searchedNotes.assignAll(notes);
      return;
    }

    try {
      final result = await repository.searchNotes(query.trim());

      searchedNotes.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Search failed: $e');
    }
  }
}
