import 'package:get/get.dart';

import '../../domain/usecases/signup_use_case.dart';
import 'signup_controller.dart';

class SignupBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupController(Get.find()));
    Get.lazyPut(() => SignupUseCase(Get.find(), Get.find(), Get.find()));
  }
}
