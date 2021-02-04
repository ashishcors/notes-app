import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/app.dart';
import 'core/services/prefs_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _initServices();

  runApp(App());
}

Future<void> _initServices() async {
  await Get.putAsync<PrefsService>(
    () async => await PrefsService.getInstance(),
  );
}
