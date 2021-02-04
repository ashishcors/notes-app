import 'package:get/get.dart';

import '../../domain/usecases/get_notes_stream_use_case.dart';
import 'home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetNotesSteamNoteUseCase>(
        () => GetNotesSteamNoteUseCase(Get.find(), Get.find()));
    Get.lazyPut(() => HomeController(Get.find(), Get.find(), Get.find()));
  }
}
