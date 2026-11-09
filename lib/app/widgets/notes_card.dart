import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_notes_app/core/theme/app_color.dart';
import '../../core/model/NoteModel.dart';
import '../../features/home/controller/home_controller.dart';
import '../routes.dart';
import '../utils/date_formats.dart';

Widget buildNoteCard(
  BuildContext context,
  HomeController controller,
  NoteModel note,
) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(AppRoutes.crud, arguments: note);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Color(note.colorValue),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  note.title.isEmpty ? 'Untitled' : note.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF202124),
                  ),
                ),
              ),
              if (note.isPinned)
                const Icon(Icons.push_pin, size: 16, color: Colors.orange),
              PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                iconColor:
                    Theme.of(context).textTheme.bodyLarge?.color ??
                    AppColors.info,
                icon: Icon(
                  Icons.more_vert,
                  size: 20,
                  color:
                      Theme.of(context).textTheme.bodyLarge?.color ??
                      AppColors.info,
                ),
                onSelected: (value) {
                  switch (value) {
                    case 'pin':
                      controller.togglePin(note);
                      break;
                    case 'delete':
                      Future.delayed(const Duration(milliseconds: 150), () {
                        if (!context.mounted) return;

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: const Text('Delete Note?'),
                              content: const Text(
                                'Are you sure you want to delete this note? '
                                    'This action cannot be undone.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                    controller.deleteNote(note.id);
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      });
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'pin',
                    child: Text(note.isPinned ? 'Unpin' : 'Pin'),
                  ),
                  const PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          Expanded(
            child: Text(
              note.content,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                height: 1.4,
                color: Color(0xFF5F6368),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            formatDate(note.updatedAt),
            style: const TextStyle(fontSize: 11, ),
          ),
        ],
      ),
    ),
  );
}
