import 'package:get/get.dart';

import '../../../data/repository/notes_repository.dart';
import '../controller/crud_controller.dart';

class CrudBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CrudController>(
      () => CrudController(Get.find<NoteRepository>()),
    );
  }
}
