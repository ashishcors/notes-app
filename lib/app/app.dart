import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import '../core/utils/app_themes.dart';
import '../routing/app_pages.dart';
import 'app_bindings.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "QNote",
      theme: AppTheme.LIGHT,
      getPages: AppPages.routes,
      initialRoute: AppPages.INITIAL,
      initialBinding: AppBindings(),
    );
  }
}
