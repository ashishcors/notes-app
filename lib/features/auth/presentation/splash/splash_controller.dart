import 'package:get/get.dart';

import '../../../../routing/app_pages.dart';
import '../../domain/usecases/check_email_verified_use_case.dart';
import '../../domain/usecases/get_logged_in_user_use_case.dart';

class SplashController extends GetxController {
  final GetLoggedInUserUseCase _loggedInUserUseCase;
  final CheckEmailVerifiedUseCase _checkEmailVerifiedUseCase;

  SplashController(this._loggedInUserUseCase, this._checkEmailVerifiedUseCase);

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkLoggedInUser();
  }

  Future<void> _checkLoggedInUser() async {
    isLoading.value = true;
    final result = await _loggedInUserUseCase(null);
    result.fold(
      (value) {
        _checkEmailVerified();
      },
      (exception) {
        isLoading.value = false;
        Get.offNamed(Routes.LOGIN);
      },
    );
  }

  Future<void> _checkEmailVerified() async {
    final result = await _checkEmailVerifiedUseCase(null);
    result.fold(
      (value) {
        isLoading.value = false;
        if (value)
          Get.offNamed(Routes.HOME);
        else
          Get.offNamed(Routes.EMAIL_VERIFICATION);
      },
      (exception) {
        isLoading.value = false;
        Get.snackbar("Error!", exception.toString());
      },
    );
  }
}
