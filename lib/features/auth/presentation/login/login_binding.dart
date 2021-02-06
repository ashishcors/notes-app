import 'package:get/get.dart';

import '../../domain/usecases/login_use_case.dart';
import 'login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(Get.find()));
    Get.lazyPut(() => LoginUseCase(Get.find(), Get.find()));
  }
}
