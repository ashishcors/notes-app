import 'package:get/get.dart';
import 'package:notesapp/routing/app_pages.dart';

import '../../domain/usecases/get_logged_in_user_use_case.dart';

class SplashController extends GetxController {
  final GetLoggedInUserUseCase _loggedInUserUseCase;

  SplashController(this._loggedInUserUseCase);

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
        isLoading.value = false;
        Get.toNamed(Routes.HOME);
      },
      (exception) {
        isLoading.value = false;
        Get.toNamed(Routes.LOGIN);
      },
    );
  }
}
