import 'package:get/get.dart';

import '../../../core/db/database_service.dart';
import '../../../data/repository/notes_repository.dart';
import '../controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    final database = Get.find<DatabaseService>();

    Get.lazyPut<NoteRepository>(() => NoteRepository(database.db));

    Get.lazyPut<HomeController>(
      () => HomeController(Get.find<NoteRepository>()),
    );
  }
}
