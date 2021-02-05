import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routing/app_pages.dart';
import '../../domain/usecases/login_use_case.dart';

class LoginController extends GetxController {
  final LoginUseCase _loginUseCase;

  LoginController(this._loginUseCase);

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final isLoading = false.obs;

  // TODO: break this
  Future<void> login() async {
    final email = emailTextController.text;
    final password = passwordTextController.text;

    if (email == null || email.isEmpty) {
      Get.snackbar("Incomplete data!", "Email is required");
      return null;
    }

    if (password == null || password.isEmpty) {
      Get.snackbar("Incomplete data!", "Password is required");
      return null;
    }

    isLoading.value = true;
    final result = await _loginUseCase(LoginParams(email, password));
    result.fold(
      (value) {
        isLoading.value = false;
        Get.offNamed(Routes.HOME);
      },
      (exception) {
        isLoading.value = false;
        Get.snackbar("Login error!", exception.toString());
      },
    );
  }
}
