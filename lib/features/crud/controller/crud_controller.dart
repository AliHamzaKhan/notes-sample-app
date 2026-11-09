
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/model/NoteModel.dart';
import '../../../data/repository/notes_repository.dart';
import '../../home/controller/home_controller.dart';

class CrudController extends GetxController {
  final NoteRepository repository;

  CrudController(this.repository);

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final isSaving = false.obs;

  NoteModel? existingNote;

  bool get isEditing => existingNote != null;

  @override
  void onInit() {
    super.onInit();

    final argument = Get.arguments;

    if (argument is NoteModel) {
      existingNote = argument;

      titleController.text = argument.title;
      contentController.text = argument.content;
    }
  }

  Future<void> saveNote() async {
    if (isSaving.value) return;

    if (titleController.text.trim().isEmpty &&
        contentController.text.trim().isEmpty) {
      Get.snackbar(
        'Empty Note',
        'Please enter a title or some content.',
      );
      return;
    }

    try {
      isSaving.value = true;

      final wasEditing = isEditing;

      if (wasEditing) {
        final note = existingNote!;

        note
          ..title = titleController.text.trim()
          ..content = contentController.text.trim()
          ..updatedAt = DateTime.now();

        await repository.updateNote(note);
      } else {
        final now = DateTime.now();

        final note = NoteModel()
          ..title = titleController.text.trim()
          ..content = contentController.text.trim()
          ..createdAt = now
          ..updatedAt = now;

        await repository.createNote(note);
      }

      if (Get.isRegistered<HomeController>()) {
        await Get.find<HomeController>().loadNotes();
      }

      Get.back();

      Get.snackbar(
        'Success',
        wasEditing ? 'Note updated successfully' : 'Note created successfully',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Unable to save note: $e',
      );
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }
}
