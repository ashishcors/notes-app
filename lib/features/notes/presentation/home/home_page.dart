import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../../routing/app_pages.dart';
import 'home_controller.dart';
import 'widgets/drawer_layout.dart';
import 'widgets/note_view.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Get.toNamed(Routes.ADD_NOTE),
      ),
      body: SafeArea(
        child: HomePageLayout(controller),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Obx(
          () => Text(
            '${controller.userDisplayName.value ?? 'Nameless Fellow'}\'s Notes',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: DrawerLayout(controller),
      ),
    );
  }
}

class HomePageLayout extends StatelessWidget {
  final HomeController controller;

  HomePageLayout(this.controller);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => StaggeredGridView.countBuilder(
        itemBuilder: (context, i) => NoteView(controller.notes[i]),
        itemCount: controller.notes.length,
        crossAxisCount: _crossAxisCount(),
        staggeredTileBuilder: (int index) {
          return StaggeredTile.fit(1);
        },
      ),
    );
  }

  int _crossAxisCount() {
    final screenSize = Get.width;
    if (screenSize > 1000) return 6;
    if (screenSize > 800) return 5;
    if (screenSize > 600) return 3;
    return 2;
  }
}
