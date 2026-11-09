import 'package:get/get.dart';

import '../../core/db/database_service.dart';
import '../../data/repository/notes_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DatabaseService>(
      DatabaseService(),
      permanent: true,
    );
    final database = Get.find<DatabaseService>();
    Get.put<NoteRepository>(
      NoteRepository(database.db),
      permanent: true,
    );
  }
}