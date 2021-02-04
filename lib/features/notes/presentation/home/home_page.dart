import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routing/app_pages.dart';
import '../../domain/entities/note.dart';
import 'drawer/drawer_layout.dart';
import 'home_controller.dart';

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
    return SingleChildScrollView(
      child: Obx(
        () => GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _crossAxisCount(context),
          ),
          shrinkWrap: true,
          itemBuilder: (context, i) => NoteView(controller.notes[i]),
          itemCount: controller.notes.length,
        ),
      ),
    );
  }

  int _crossAxisCount(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;
    if (screenSize > 1000) return 5;
    if (screenSize > 800) return 4;
    if (screenSize > 600) return 3;
    return 2;
  }
}

class NoteView extends StatelessWidget {
  final Note _note;

  NoteView(this._note);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.EDIT_NOTE, arguments: _note),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 2),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _note.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              //Todo: Improve this
              _note.message,
              overflow: TextOverflow.fade,
              softWrap: true,
              maxLines: 7,
            ),
          ],
        ),
      ),
    );
  }
}
