import 'package:get/get.dart';

import '../../domain/usecases/add_note_use_case.dart';
import '../../domain/usecases/delete_note_use_case.dart';
import '../../domain/usecases/update_note_use_case.dart';
import 'edit_note_controller.dart';

class EditNoteBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<DeleteNoteUseCase>(DeleteNoteUseCase(Get.find(), Get.find()));
    Get.put<UpdateNoteUseCase>(UpdateNoteUseCase(Get.find(), Get.find()));
    Get.put<AddNoteUseCase>(AddNoteUseCase(Get.find(), Get.find()));
    Get.put<EditNoteController>(
        EditNoteController(Get.find(), Get.find(), Get.find()));
  }
}
