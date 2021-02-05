import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routing/app_pages.dart';
import '../../domain/usecases/signup_use_case.dart';

class SignupController extends GetxController {
  final SignupUseCase _signupUseCase;

  SignupController(this._signupUseCase);

  final isLoading = false.obs;

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  // TODO: break this
  Future<void> signup() async {
    final name = nameTextController.text;
    final email = emailTextController.text;
    final password = passwordTextController.text;

    if (name == null || name.isEmpty) {
      Get.snackbar("Incomplete data!", "Name is required");
      return null;
    }

    if (email == null || email.isEmpty) {
      Get.snackbar("Incomplete data!", "Email is required");
      return null;
    }

    if (password == null || password.isEmpty) {
      Get.snackbar("Incomplete data!", "Password is required");
      return null;
    }

    isLoading.value = true;
    final result = await _signupUseCase(SignupParams(name, email, password));
    result.fold(
      (value) {
        isLoading.value = false;
        Get.offNamed(Routes.EMAIL_VERIFICATION);
      },
      (exception) {
        isLoading.value = false;
        Get.snackbar("Signup error!", exception.toString());
      },
    );
  }
}
