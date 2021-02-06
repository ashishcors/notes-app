import 'package:get/get.dart';

import '../../domain/usecases/check_email_verified_use_case.dart';
import '../../domain/usecases/send_verification_email_use_case.dart';
import 'email_verification_controller.dart';

class EmailVerificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<CheckEmailVerifiedUseCase>(
        CheckEmailVerifiedUseCase(Get.find(), Get.find()));
    Get.put<SendVerificationEmailUseCase>(
        SendVerificationEmailUseCase(Get.find()));
    Get.put<EmailVerificationController>(
        EmailVerificationController(Get.find(), Get.find()));
  }
}
