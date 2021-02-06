import 'package:get/get.dart';

import '../../domain/usecases/check_email_verified_use_case.dart';
import 'splash_controller.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<CheckEmailVerifiedUseCase>(
        CheckEmailVerifiedUseCase(Get.find(), Get.find()));
    Get.put<SplashController>(SplashController(Get.find(), Get.find()));
  }
}
