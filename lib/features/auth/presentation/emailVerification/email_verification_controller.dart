import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routing/app_pages.dart';
import '../../domain/usecases/check_email_verified_use_case.dart';
import '../../domain/usecases/send_verification_email_use_case.dart';

class EmailVerificationController extends GetxController
    with WidgetsBindingObserver {
  final CheckEmailVerifiedUseCase _checkEmailVerifiedUseCase;
  final SendVerificationEmailUseCase _sendVerificationEmailUseCase;

  EmailVerificationController(
      this._checkEmailVerifiedUseCase, this._sendVerificationEmailUseCase);

  final isLoading = false.obs;

  _checkEmailVerified() async {
    isLoading.value = true;
    final result = await _checkEmailVerifiedUseCase(null);
    result.fold(
      (value) {
        isLoading.value = false;
        if (value) Get.offNamed(Routes.HOME);
      },
      (exception) {
        isLoading.value = false;
        // do nothing
      },
    );
  }

  sendVerificationEmail() async {
    isLoading.value = true;
    final result = await _sendVerificationEmailUseCase(null);
    result.fold(
      (value) {
        isLoading.value = false;
        Get.snackbar(
          "Verification email sent",
          "Verify your account by clicking on link sent to your email address.",
        );
      },
      (exception) {
        isLoading.value = false;
        Get.snackbar(
          "Error!",
          exception.toString(),
        );
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    _checkEmailVerified();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _checkEmailVerified();
    }
  }
}
