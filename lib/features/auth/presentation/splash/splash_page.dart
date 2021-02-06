import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/app_logo.dart';
import 'splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppLogo(),
            SizedBox(height: 40),
            Obx(() => Visibility(
                  child: CircularProgressIndicator(),
                  visible: controller.isLoading.value,
                )),
          ],
        ),
      ),
    );
  }
}
