
import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(Get.find()));
  }
}